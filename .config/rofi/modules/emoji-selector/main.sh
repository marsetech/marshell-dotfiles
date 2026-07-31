#!/usr/bin/env bash
set -euo pipefail

# ---- Variables ---------------------------------------------------
EMOJI_FILE="${ROFI_CONFIG:-$HOME/.config/rofi/modules/emoji-selector/database/emoji.txt}"
ROFI_CONFIG="${ROFI_CONFIG:-$HOME/.config/rofi/config/layouts/utils-selector.rasi}"

# ---- Show Rofi menu and read selection ----------------------------------------------
selection=$(rofi -dmenu -i -p "Emoticon:" -config "$ROFI_CONFIG" < "$EMOJI_FILE")

# ---- Extract first field ---------------------------
emoji=$(echo "$selection" | awk '{print $1}')

# ---- Copy to clipboard if selection is not empty ---------------------
if [ -n "$emoji" ]; then
	echo -n "$emoji" | wl-copy
fi
