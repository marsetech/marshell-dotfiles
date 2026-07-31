#!/usr/bin/env bash
set -euo pipefail

readonly ROFI_HOME="$HOME/.config/rofi"
readonly LIB_DIR="$ROFI_HOME/lib"
readonly ROFI_CONFIG="${ROFI_CONFIG:-$ROFI_HOME/config/layouts/utils-selector.rasi}"
readonly MAIN_MENU="$ROFI_HOME/menus/utility-selection.toml"

source "$LIB_DIR/log.sh"
source "$LIB_DIR/menu.sh"

main() {
  local dep
  for dep in rofi jq python3; do
    command -v "$dep" >/dev/null 2>&1 || { log::error "Missing dependency: $dep"; exit 1; }
  done
  menu::show "$MAIN_MENU" "$ROFI_CONFIG"
}

main "$@"
