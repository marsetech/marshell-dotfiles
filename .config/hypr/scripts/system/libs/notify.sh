#!/usr/bin/env bash

set -euo pipefail

notify() {
  notify-send "Bluetooth" "$1"
}
