#!/usr/bin/env bash
set -euo pipefail

# --------------------------------------------------------------------------------
# Configuration
# --------------------------------------------------------------------------------
ROFI_CONFIG="${ROFI_CONFIG:-$HOME/.config/rofi/config/layouts/clipboard.rasi}"

# --------------------------------------------------------------------------------
# Utility functions
# --------------------------------------------------------------------------------

# Display a rofi dmenu with given items
show_menu() {
  local prompt="${1:-Select}"
  shift
  local items=("$@")
  printf "%s\n" "${items[@]}" | rofi -dmenu -i -p "$prompt" -config "$ROFI_CONFIG"
}

# Copy text into the Wayland clipboard
copy_to_clipboard() {
  local text="$1"
  printf '%s' "$text" | wl-copy
}

# Send a desktop notification
notify() {
  local title="$1"
  local message="$2"
  notify-send "$title" "$message"
}

# --------------------------------------------------------------------------------
# Clipboard actions
# --------------------------------------------------------------------------------

# Delete all entries
remove_all() {
  cliphist wipe
  notify "Clipboard" "All items removed"
}

# Delete the last item in history
clear_last() {
  # Get the last line of cliphist list
  local last_line
  last_line=$(cliphist list | tail -n1)

  # If no output, history is empty
  if [[ -z "$last_line" ]]; then
    notify "Clipboard" "Clipboard is empty"
    return
  fi

  # Extract the ID (before tab)
  local last_id
  last_id=$(printf "%s" "$last_line" | awk -F $'\t' '{print $1}')

  # If valid numeric ID, delete it
  if [[ "$last_id" =~ ^[0-9]+$ ]]; then
    cliphist delete "$last_id"
    notify "Clipboard" "Last item removed"
  else
    notify "Clipboard" "Clipboard is empty"
  fi
}

# Show actions menu
handle_actions() {
  local action
  action=$(show_menu "Clipboard Actions" \
    " Remove All" \
    "󰈚 Clear Last")
  [[ -z "$action" ]] && return

  # Extract the internal label after '|'
  action="${action#*|}"

  case "$action" in
    " Remove All") remove_all ;;
    "󰈚 Clear Last") clear_last ;;
    *) return ;;
  esac
}

# --------------------------------------------------------------------------------
# Main logic
# --------------------------------------------------------------------------------

main() {
  # Read full list lines (each contains <id><TAB><preview>)
  mapfile -t lines < <(cliphist list)

  # If no entries, exit
  [[ ${#lines[@]} -eq 0 ]] && exit 0

  # Extract previews for the menu (second column)
  local previews=()
  for entry in "${lines[@]}"; do
    previews+=("$(printf '%s' "$entry" | cut -f2-)")
  done

  # Build the dmenu list: actions first, then previews
  local menu_items=("⚙ Actions →")
  menu_items+=("${previews[@]}")

  # Show menu
  local selection
  selection=$(show_menu "Clipboard" "${menu_items[@]}")
  [[ -z "$selection" ]] && exit 0

  # If actions menu
  if [[ "$selection" == "⚙ Actions →" ]]; then
    handle_actions
    exit 0
  fi

  # Find the index of the selected preview
  local index
  for i in "${!previews[@]}"; do
    if [[ "$selection" == "${previews[i]}" ]]; then
      index="$i"
      break
    fi
  done

  # Decode the selected entry via its original line and copy
  printf "%s" "${lines[index]}" | cliphist decode | wl-copy
}

# --------------------------------------------------------------------------------
# Entry point
# --------------------------------------------------------------------------------
main
