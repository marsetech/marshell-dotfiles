#!/usr/bin/env bash

set -euo pipefail

readonly SYSTEM_SERVICE_LIB_DIRECTORY="$HOME/.config/hypr/scripts/system/libs"

source "$SYSTEM_SERVICE_LIB_DIRECTORY/notify.sh"

pkexec systemctl restart bluetooth.service blueman-mechanism.service
notify "Bluetooth restarted"
