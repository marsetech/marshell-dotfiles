#!/usr/bin/env bash

set -euo pipefail

readonly BROWSER_DESKTOP_ENTRY="$(xdg-mime query default x-scheme-handler/http)"

gtk-launch "${BROWSER_DESKTOP_ENTRY%.desktop}"
