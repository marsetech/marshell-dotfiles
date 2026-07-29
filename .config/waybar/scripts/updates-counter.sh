#!/usr/bin/env bash
set -euo pipefail

updates=$(checkupdates 2>/dev/null | wc -l)

(( updates > 0 )) || exit 0

echo "$updates"
