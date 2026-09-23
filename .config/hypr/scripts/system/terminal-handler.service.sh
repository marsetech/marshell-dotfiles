#!/usr/bin/env bash

set -euo pipefail

if (($# == 0)); then
    exec xdg-terminal-exec
fi

exec xdg-terminal-exec -- "$@"
