#!/usr/bin/env bash

set -euo pipefail

readonly MIME_TYPE="x-scheme-handler/http"
readonly DESKTOP_ENTRY="$(xdg-mime query default "$MIME_TYPE")"

if [[ -z "$DESKTOP_ENTRY" ]]; then
    exit 1
fi

exec gtk-launch "${DESKTOP_ENTRY%.desktop}"
