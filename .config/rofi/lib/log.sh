#!/usr/bin/env bash

[[ -n "${_ROFI_LIB_LOG_SH:-}" ]] && return 0
readonly _ROFI_LIB_LOG_SH=1

log::_ts()   { date '+%Y-%m-%d %H:%M:%S'; }
log::info()  { printf '\033[1;34m[INFO]\033[0m  %s %s\n' "$(log::_ts)" "$*" >&2; }
log::warn()  { printf '\033[1;33m[WARN]\033[0m  %s %s\n' "$(log::_ts)" "$*" >&2; }
log::error() { printf '\033[1;31m[ERROR]\033[0m %s %s\n' "$(log::_ts)" "$*" >&2; }
