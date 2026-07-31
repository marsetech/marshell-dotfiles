#!/usr/bin/env bash
set -euo pipefail

# -------------------------
# Configuration
# -------------------------
ROFI_CONFIG="${ROFI_CONFIG:-$HOME/.config/rofi/config/layouts/utils-selector.rasi}"
SCREENSHOT_DIR="$HOME/Pictures/screenshots"

# -------------------------
# Functions
# -------------------------
notify() {
  # optional notification
  command -v notify-send &>/dev/null && notify-send "Screenshot" "$1"
}

choose_option() {
  local prompt="$1"
  shift
  printf "%s\n" "$@" | rofi -dmenu -i -p "$prompt" -config "$ROFI_CONFIG"
}

take_screenshot() {
  local mode="$1"
  local output_type="$2"
  local output_arg=""

  if [[ "$output_type" == "clipboard" ]]; then
    output_arg="--clipboard-only"
  else
    mkdir -p "$SCREENSHOT_DIR"
    output_arg="-o $SCREENSHOT_DIR"
  fi

  hyprshot -m "$mode" $output_arg
  [[ "$output_type" != "clipboard" ]] && notify "Screenshot saved in $SCREENSHOT_DIR"
}

# -------------------------
# Main logic
# -------------------------

# 1) Choose mode
screen_choice=$(choose_option "Screenshot:" "󰩭  Section" "󱂬  Window" "󰊓  Fullscreen")
[[ -z "$screen_choice" ]] && exit 0

# Map human-readable labels to hyprshot mode
case "$screen_choice" in
  "󰩭  Section") mode="region" ;;
  "󱂬  Window") mode="window" ;;
  "󰊓  Fullscreen") mode="output" ;;
  *) exit 1 ;;
esac

# 2) Choose output
type_choice=$(choose_option "Output:" "  Clipboard" "  File")
[[ -z "$type_choice" ]] && exit 0

case "$type_choice" in
  *Clipboard*) output="clipboard" ;;
  *File*) output="file" ;;
  *) exit 1 ;;
esac

# 3) Take screenshot
take_screenshot "$mode" "$output"
