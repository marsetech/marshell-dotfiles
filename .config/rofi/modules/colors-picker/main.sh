#!/usr/bin/env bash
set -euo pipefail

NOTIFY_CMD="notify-send"
CLIP_CMD="wl-copy"

# (Optional) Delay to allow focus transition
DELAY=0.25

launch_picker() {
  sleep "$DELAY"

  local color
  color=$(hyprpicker 2>/dev/null)

  if [[ -n "$color" ]]; then
    echo -n "$color" | $CLIP_CMD
    $NOTIFY_CMD "Color Picker" "Copied color: $color"
  fi
}

launch_picker
