#!/usr/bin/env bash

[[ -n "${_ROFI_LIB_MENU_SH:-}" ]] && return 0
readonly _ROFI_LIB_MENU_SH=1

_ROFI_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$_ROFI_LIB_DIR/log.sh"
source "$_ROFI_LIB_DIR/toml.sh"

# menu::show <toml_file> <rofi_config>
menu::show() {
  local menu_file="$1"
  local rofi_config="$2"

  [[ -f "$menu_file" ]] || { log::error "Menu file not found: $menu_file"; exit 1; }

  local json title
  json="$(toml::to_json "$menu_file")" || exit 1
  title="$(jq -r '.menu.title // "Rofi Scripts"' <<<"$json")"

  local -A commands=()
  local labels=()

  while IFS=$'\t' read -r label exec_cmd; do
    [[ -z "$label" ]] && continue
    labels+=("$label")
    commands["$label"]="$exec_cmd"
  done < <(jq -r '.item[] | [((.icon // "") + " " + .label), .exec] | @tsv' <<<"$json")

  local choice
  choice="$(printf '%s\n' "${labels[@]}" | rofi -dmenu -i -p "$title" -config "$rofi_config")"
  [[ -z "$choice" ]] && return 0

  local cmd="${commands[$choice]:-}"
  [[ -z "$cmd" ]] && { log::error "No command bound to selection: $choice"; return 1; }

  menu::dispatch "$cmd" "$rofi_config"
}

# menu::dispatch <cmd> <rofi_config>
menu::dispatch() {
  local cmd="$1" rofi_config="$2"

  # Expand env vars declared in the TOML (e.g. $HOME) — trusted, user-owned file
  cmd="$(eval echo "$cmd")"

  if [[ "$cmd" == *.toml ]]; then
    menu::show "$cmd" "$rofi_config"
  else
    if ! bash -c "$cmd"; then
      log::error "Failed to execute: $cmd"
      return 1
    fi
  fi
}
