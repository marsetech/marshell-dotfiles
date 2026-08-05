#!/usr/bin/env bash
# ==============================================================================
# file-manager-session-manager.sh
# ------------------------------------------------------------------------------
# Smart launcher for yazi inside Kitty on Hyprland.
# Opens a new tab/window if no session is active, or focuses the existing one.
# Supports separate user and elevated (root) sessions.
#
# Usage:
#   file-manager-session-manager.sh [--user|--system]
#
# Dependencies: kitty, hyprctl, jq, yazi
#
# Detection/focus works by inspecting the *running process* inside each Kitty
# tab (via `kitty @ ls` -> foreground_processes[].cmdline), NOT the terminal
# title. yazi rewrites its tab title on every directory change (e.g.
# "Yazi: marcy", "Yazi: Download"), and yazi has no supported option to
# disable this, so title-based matching is unreliable and no longer used.
# ==============================================================================

set -euo pipefail

# ==============================================================================
# CONFIGURATION
# ==============================================================================

readonly TERMINAL="kitty"
readonly FILE_MANAGER="yazi"
readonly WORKSPACE="1"

# ==============================================================================
# ARGUMENT PARSING
# ==============================================================================

MODE="user"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --user)   MODE="user"   ;;
        --system) MODE="system" ;;
        *)        ;;
    esac
    shift
done

# ==============================================================================
# SESSION CONFIGURATION
# ------------------------------------------------------------------------------
# SYSTEM MODE — privilege escalation strategies (one active at a time):
#
#   [ACTIVE]  sudo -E
#             Password prompt appears inside the Kitty tab.
#             Preserves the full user environment.
#
#   [ALT 1]   pkexec + sudo -E
#             Graphical polkit dialog. Environment is partially stripped by
#             polkit before sudo -E runs; use if you don't rely on user env.
#             Uncomment to activate.
#
#   [ALT 2]   pkexec with full env injection
#             Graphical dialog + explicit env passthrough via `env`, bypassing
#             polkit's sanitisation whitelist. Handles values with spaces/newlines
#             via NUL-delimited input.
#             Uncomment both lines to activate.
# ==============================================================================

if [[ "$MODE" == "system" ]]; then
    CMD=(sudo -E "$FILE_MANAGER")
    # ALT 1:
    # CMD=(pkexec sh -c "sudo -E '$FILE_MANAGER'")
    #
    # ALT 2:
    # mapfile -d '' ENV_ARGS < <(env -0)
    # CMD=(pkexec env "${ENV_ARGS[@]}" sh -c "sudo -E '$FILE_MANAGER'")
else
    CMD=("$FILE_MANAGER")
fi

# ==============================================================================
# KITTY HELPERS
# ==============================================================================

# Returns the Unix socket path for a given Kitty PID.
# Requires `listen_on unix:/tmp/kitty-socket-{kitty_pid}` in kitty.conf.
kitty_socket() {
    echo "unix:/tmp/kitty-socket-${1}"
}

# Prints "pid address" for every open Kitty OS window (one pair per line).
list_kitty_windows() {
    hyprctl clients -j | jq -r '
        .[]
        | select(.class == "kitty")
        | "\(.pid) \(.address)"
    '
}

# ==============================================================================
# SESSION DETECTION
# ==============================================================================

# Searches all open Kitty windows (via their remote-control socket) for a
# window/pane whose foreground process cmdline matches the expected pattern
# for the current MODE. This is process-based, not title-based, so it is
# unaffected by yazi's per-directory title changes and works even for yazi
# sessions started outside this script.
#
# Outputs "window_id kitty_pid hyprland_address" if found; empty otherwise.
find_session() {
    local pid address socket tabs_json window_id pattern

    # Oniguruma (jq's regex engine) supports lookahead, so we can explicitly
    # exclude sudo sessions from the plain "user" match, and vice versa.
    if [[ "$MODE" == "system" ]]; then
        pattern='.*sudo.*\byazi\b'
    else
        pattern='^(?!.*sudo).*\byazi\b'
    fi

    while read -r pid address; do
        [[ -z "$pid" ]] && continue

        socket="$(kitty_socket "$pid")"
        tabs_json="$(kitty @ --to "$socket" ls 2>/dev/null)" || continue

        window_id="$(jq -r --arg pat "$pattern" '
            .[].tabs[].windows[]?
            | select(
                (.foreground_processes // [])
                | map(.cmdline // [] | join(" "))
                | any(test($pat))
              )
            | .id
        ' <<< "$tabs_json" | head -n1)"

        if [[ -n "$window_id" && "$window_id" != "null" ]]; then
            echo "$window_id $pid $address"
            return 0
        fi
    done < <(list_kitty_windows)

    echo ""
}

# Returns the PID of any open Kitty window, used to decide whether to open
# a new tab in an existing window or a brand-new OS window.
find_any_kitty_pid() {
    list_kitty_windows | head -n1 | awk '{print $1}'
}

# ==============================================================================
# WORKSPACE FOCUS
# ==============================================================================

# Switches Hyprland focus to the configured workspace.
focus_workspace() {
    hyprctl dispatch workspace "$WORKSPACE"
}

# After a new OS window is launched, waits until Hyprland registers it on the
# target workspace (up to 2 s), then schedules a second workspace focus via a
# 500 ms one-shot timer. This prevents focus races when a new window spawns.
wait_and_focus_workspace() {
    focus_workspace

    local attempts=0
    local max_attempts=40   # 40 × 50 ms = 2 s
    until hyprctl clients -j | jq -e --arg ws "$WORKSPACE" '
        .[] | select(.class == "kitty" and (.workspace.name == $ws))
    ' >/dev/null 2>&1; do
        (( attempts++ ))
        if (( attempts >= max_attempts )); then break; fi
        sleep 0.05
    done

    hyprctl eval "
        hl.timer(
            function() hl.dispatch(hl.dsp.focus({ workspace = \"$WORKSPACE\" })) end,
            { timeout = 50, type = \"oneshot\" }
        )
    "
}

# ==============================================================================
# LAUNCH / FOCUS ACTIONS
# ==============================================================================

# Opens a new Kitty OS window running yazi, then focuses the workspace.
launch_window() {
    $TERMINAL --detach "${CMD[@]}"
    wait_and_focus_workspace
}

# Opens a new tab in an existing Kitty window (identified by PID).
launch_tab() {
    local pid="$1"
    local socket
    socket="$(kitty_socket "$pid")"

    local new_window_id
    new_window_id="$(kitty @ --to "$socket" launch --type=tab "${CMD[@]}")"

    wait_and_focus_workspace

    kitty @ --to "$socket" focus-window --match "id:${new_window_id}" \
        >/dev/null 2>&1 || true
}

# Focuses an already-open yazi session: workspace → Hyprland window → pane.
# Matching is done by kitty window id (stable, process-derived), not by
# title, so it survives yazi's per-directory title changes.
focus_session() {
    local window_id="$1"
    local pid="$2"
    local address="$3"
    local socket
    socket="$(kitty_socket "$pid")"

    wait_and_focus_workspace

    # If multiple Kitty OS windows live on the same workspace, the workspace
    # switch alone doesn't guarantee the right one is on top — focus it
    # explicitly via Hyprland first.
    hyprctl dispatch focuswindow "address:${address}" >/dev/null 2>&1 || true

    kitty @ --to "$socket" focus-window --match "id:${window_id}" \
        >/dev/null 2>&1 || true
}

# ==============================================================================
# MAIN
# ==============================================================================

main() {
    local result window_id pid address any_pid

    result="$(find_session)"

    if [[ -n "$result" ]]; then
        # Session already open — focus it instead of opening a duplicate.
        window_id="$(awk '{print $1}' <<< "$result")"
        pid="$(awk '{print $2}'       <<< "$result")"
        address="$(awk '{print $3}'   <<< "$result")"
        focus_session "$window_id" "$pid" "$address"
        return
    fi

    any_pid="$(find_any_kitty_pid)"

    if [[ -n "$any_pid" ]]; then
        # Kitty is running but has no session for this mode — open a new tab.
        launch_tab "$any_pid"
    else
        # No Kitty window open at all — open a new OS window.
        launch_window
    fi
}

main
