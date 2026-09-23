#!/usr/bin/env bash

set -euo pipefail

readonly MIME_TYPE="text/plain"
readonly DESKTOP_ENTRY="$(xdg-mime query default "$MIME_TYPE")"

if [[ -z "$DESKTOP_ENTRY" ]]; then
    exit 1
fi

find_desktop_entry() {
    local desktop_entry="$1"
    local directory

    while IFS= read -r directory; do
        if [[ -f "$directory/applications/$desktop_entry" ]]; then
            printf '%s\n' "$directory/applications/$desktop_entry"
            return 0
        fi
    done < <(
        printf '%s\n' \
            "${XDG_DATA_HOME:-"$HOME/.local/share"}" \
            "${XDG_DATA_DIRS:-/usr/local/share:/usr/share}" |
        tr ':' '\n'
    )

    return 1
}

readonly DESKTOP_FILE="$(find_desktop_entry "$DESKTOP_ENTRY")"

readonly TERMINAL="$(
    sed -n 's/^Terminal=//p' "$DESKTOP_FILE" | head -n 1
)"

case "$TERMINAL" in
    false|"")
        exec gtk-launch "${DESKTOP_ENTRY%.desktop}"
        ;;

    true)
        ;;

    *)
        exit 1
        ;;
esac

readonly EXEC_COMMAND="$(
    sed -n 's/^Exec=//p' "$DESKTOP_FILE" | head -n 1
)"

if [[ -z "$EXEC_COMMAND" ]]; then
    exit 1
fi

read -r -a EXEC_ARGS <<< "$EXEC_COMMAND"

for index in "${!EXEC_ARGS[@]}"; do
    case "${EXEC_ARGS[$index]}" in
        %f|%F|%u|%U|%d|%D|%n|%N|%i|%c|%k|%v|%m)
            unset 'EXEC_ARGS[index]'
            ;;
    esac
done

readonly TERMINAL_DESKTOP_ENTRY="$(
    xdg-mime query default inode/directory
)"

if [[ -z "$TERMINAL_DESKTOP_ENTRY" ]]; then
    exit 1
fi

readonly TERMINAL_DESKTOP_FILE="$(
    find_desktop_entry "$TERMINAL_DESKTOP_ENTRY"
)"

readonly TERMINAL_COMMAND="$(
    sed -n 's/^Exec=//p' "$TERMINAL_DESKTOP_FILE" | head -n 1
)"

if [[ -z "$TERMINAL_COMMAND" ]]; then
    exit 1
fi

read -r -a TERMINAL_ARGS <<< "$TERMINAL_COMMAND"

for index in "${!TERMINAL_ARGS[@]}"; do
    case "${TERMINAL_ARGS[$index]}" in
        %f|%F|%u|%U|%d|%D|%n|%N|%i|%c|%k|%v|%m)
            unset 'TERMINAL_ARGS[index]'
            ;;
    esac
done

case "${TERMINAL_ARGS[0]}" in
    kitty|ghostty|foot)
        exec "${TERMINAL_ARGS[@]}" -e "${EXEC_ARGS[@]}"
        ;;

    *)
        exit 1
        ;;
esac
