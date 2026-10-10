#!/usr/bin/env bash

set -euo pipefail

# ============================================================================
# Configuration
# ============================================================================

NVIM_BIN="${NVIM_BIN:-nvim}"
NVIM_CONFIG="${NVIM_CONFIG:-$HOME/.config/nvim}"

# ============================================================================
# Validation
# ============================================================================

if ! command -v "$NVIM_BIN" >/dev/null 2>&1; then
  printf 'Error: Neovim executable not found: %s\n' "$NVIM_BIN" >&2
  exit 1
fi

if [[ ! -f "$NVIM_CONFIG/init.lua" ]]; then
  printf 'Error: Neovim init.lua not found: %s\n' \
    "$NVIM_CONFIG/init.lua" >&2
  exit 1
fi

printf 'Validating Neovim configuration...\n'

if "$NVIM_BIN" --headless \
  -u "$NVIM_CONFIG/init.lua" \
  -c 'qa!'; then
  printf 'Configuration loaded successfully.\n'
else
  status=$?
  printf 'Error: Neovim configuration validation failed.\n' >&2
  exit "$status"
fi
