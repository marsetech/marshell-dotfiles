#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly TERMINAL_HANDLER="$SCRIPT_DIR/terminal-handler.service.sh"

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

parse_exec() {
    local command="$1"
    local -n result="$2"
    local argument=""
    local character
    local quoted=false
    local escaped=false
    local index

    result=()

    for ((index = 0; index < ${#command}; index++)); do
        character="${command:index:1}"

        if [[ "$escaped" == true ]]; then
            argument+="$character"
            escaped=false
            continue
        fi

        if [[ "$character" == '\' ]]; then
            escaped=true
            continue
        fi

        if [[ "$character" == '"' ]]; then
            quoted=$([[ "$quoted" == true ]] && echo false || echo true)
            continue
        fi

        if [[ "$quoted" == false && "$character" =~ [[:space:]] ]]; then
            if [[ -n "$argument" ]]; then
                result+=("$argument")
                argument=""
            fi

            continue
        fi

        argument+="$character"
    done

    if [[ "$escaped" == true ]]; then
        argument+='\'
    fi

    if [[ -n "$argument" ]]; then
        result+=("$argument")
    fi
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

parse_exec "$EXEC_COMMAND" EXEC_ARGS

for index in "${!EXEC_ARGS[@]}"; do
    case "${EXEC_ARGS[$index]}" in
        %f|%F|%u|%U|%d|%D|%n|%N|%i|%c|%k|%v|%m)
            unset 'EXEC_ARGS[index]'
            ;;
    esac
done

exec "$TERMINAL_HANDLER" "${EXEC_ARGS[@]}"
