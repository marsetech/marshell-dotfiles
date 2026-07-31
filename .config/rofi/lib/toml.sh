#!/usr/bin/env bash

[[ -n "${_ROFI_LIB_TOML_SH:-}" ]] && return 0
readonly _ROFI_LIB_TOML_SH=1

# toml::to_json <file>
# Emits the parsed TOML file as a single-line JSON string on stdout.
toml::to_json() {
  local file="$1"
  [[ -f "$file" ]] || { echo "toml::to_json: file not found: $file" >&2; return 1; }

  python3 - "$file" <<'PY'
import sys, json, tomllib
with open(sys.argv[1], "rb") as f:
    data = tomllib.load(f)
json.dump(data, sys.stdout)
PY
}
