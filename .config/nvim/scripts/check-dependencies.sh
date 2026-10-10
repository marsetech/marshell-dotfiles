#!/usr/bin/env bash

set -euo pipefail

# ============================================================================
# Configuration
# ============================================================================

REQUIRED_COMMANDS=(
  git
  tree-sitter
  tree-sitter-cli
)

missing=0

# ============================================================================
# Verification
# ============================================================================

for command in "${REQUIRED_COMMANDS[@]}"; do
  if command -v "$command" >/dev/null 2>&1; then
    printf '[OK]      %s\n' "$command"
  else
    printf '[MISSING] %s\n' "$command" >&2
    missing=1
  fi
done

if (( missing )); then
  printf '\nSome required dependencies are missing.\n' >&2
  exit 1
fi

printf '\nAll required dependencies are available.\n'
