#!/usr/bin/env bash

set -euo pipefail

# ============================================================================
# Configuration
# ============================================================================

TARGETS=(
  "$HOME/.config/nvim/nvim-pack-lock.json"
  "$HOME/.local/share/nvim"
  "$HOME/.local/state/nvim"
  "$HOME/.cache/nvim"
)

DRY_RUN=false

# ============================================================================
# Arguments
# ============================================================================

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=true
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      exit 1
      ;;
  esac
done

# ============================================================================
# Cleanup
# ============================================================================

echo -e "Cleaning Neovim configuration and data...\n"

for target in "${TARGETS[@]}"; do
  if [[ ! -e "$target" && ! -L "$target" ]]; then
    continue
  fi

  if [[ "$DRY_RUN" == true ]]; then
    echo "→ Would remove $target"
  else
    echo "→ Removing $target"
    rm -rf -- "$target"
    echo "✓ Removed $target"
  fi
done

if [[ "$DRY_RUN" == true ]]; then
  echo -e "\n✓ Dry run completed."
else
  echo -e "\n✓ Neovim cleanup completed."
fi
