#!/usr/bin/env bash

set -euo pipefail

readonly SYSTEM_SERVICE_LIB_DIRECTORY="$HOME/.config/hypr/scripts/system/libs"
readonly TERMINAL_APPLICATION="kitty"
readonly TERMINAL_AUDIO_CONTROLLER_APPLICATION="bluetui"

source "$SYSTEM_SERVICE_LIB_DIRECTORY/notify.sh"

"$TERMINAL_APPLICATION" --class "$TERMINAL_AUDIO_CONTROLLER_APPLICATION" "$TERMINAL_AUDIO_CONTROLLER_APPLICATION"
notify "Bluetooth restarted"
