#!/usr/bin/env bash
set -euo pipefail

pkill -x waybar || true
pkill -x swaync || true

waybar & disown
swaync & disown
