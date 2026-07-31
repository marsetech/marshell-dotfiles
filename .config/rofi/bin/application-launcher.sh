#!/usr/bin/env bash
set -euo pipefail

# ---- Configuration ---------------------------------------------------------------
ROFI_CONFIG="${ROFI_CONFIG:-$HOME/.config/rofi/config/layouts/utils-selector.rasi}"

rofi -show drun -i -p "Applications" -config $ROFI_CONFIG
