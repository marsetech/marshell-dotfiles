#!/usr/bin/env bash
set -Eeuo pipefail

# ---- Constants ------------------------------------------------
readonly ARCH_RELEASE="/etc/arch-release"
readonly WAYBAR_SIGNAL="RTMIN+20"
readonly KITTY_TITLE="  System Update"

[[ -f "${ARCH_RELEASE}" ]] || exit 0

# ---- Utility functions ------------------------------------------------
pkg_installed() {
  local pkg="$1"

  pacman -Qi "${pkg}" &>/dev/null ||
  { pkg_installed flatpak && flatpak info "${pkg}" &>/dev/null; } ||
  command -v "${pkg}" &>/dev/null
}

detect_aur_helper() {
  if pkg_installed yay; then
    echo "yay"
  elif pkg_installed paru; then
    echo "paru"
  else
    echo ""
  fi
}

# ---- Update counters ------------------------------------------------
count_official_updates() {
  while pgrep -x checkupdates &>/dev/null; do
    sleep 1
  done

  checkupdates | wc -l
}

count_aur_updates() {
  local helper="$1"
  [[ -z "${helper}" ]] && echo 0 && return

  "${helper}" -Qua | wc -l
}

count_flatpak_updates() {
  pkg_installed flatpak || { echo 0; return; }

  flatpak remote-ls --updates | wc -l
}

# ---- Update execution ------------------------------------------------
run_upgrade() {
  local helper="$1"

  trap 'pkill -'"${WAYBAR_SIGNAL}"' waybar 2>/dev/null || true' EXIT

  kitty --title "${KITTY_TITLE}" sh -c "
    ${0} upgrade
    ${helper} -Syu
    $(pkg_installed flatpak && echo "flatpak update")
    echo
    read -n 1 -p 'Press any key to continue...'
  "
}

# ---- Output formatting ------------------------------------------------
print_upgrade_summary() {
  local official="$1"
  local aur="$2"
  local flatpak="$3"
  local helper="$4"

  printf \
    "󰏔 Official:   %-10s\n AUR (%s): %-10s\n Flatpak:    %-10s\n\n" \
    "${official}" "${helper}" "${aur}" "${flatpak}"
}

build_tooltip() {
  local official="$1"
  local aur="$2"
  local flatpak="$3"
  local helper="$4"

  printf \
    "Official:   %s\nAUR (%s): %s\nFlatpak:    %s" \
    "${official}" "${helper}" "${aur}" "${flatpak}"
}

# ---- Main logic ------------------------------------------------
AUR_HELPER="$(detect_aur_helper)"

# Upgrade trigger
if [[ "${1:-}" == "up" && -n "${AUR_HELPER}" ]]; then
  run_upgrade "${AUR_HELPER}"
  exit 0
fi

OFFICIAL_UPDATES="$(count_official_updates)"
AUR_UPDATES="$(count_aur_updates "${AUR_HELPER}")"
FLATPAK_UPDATES="$(count_flatpak_updates)"
TOTAL_UPDATES=$((OFFICIAL_UPDATES + AUR_UPDATES + FLATPAK_UPDATES))

# CLI mode
if [[ "${1:-}" == "upgrade" && -n "${AUR_HELPER}" ]]; then
  print_upgrade_summary \
    "${OFFICIAL_UPDATES}" \
    "${AUR_UPDATES}" \
    "${FLATPAK_UPDATES}" \
    "${AUR_HELPER}"
  exit 0
fi

# ---- Waybar JSON output ------------------------------------------------
if (( TOTAL_UPDATES == 0 )); then
  echo '{"text":"󰸟","tooltip":"Packages are up to date"}'
else
  TOOLTIP="$(build_tooltip \
    "${OFFICIAL_UPDATES}" \
    "${AUR_UPDATES}" \
    "${FLATPAK_UPDATES}" \
    "${AUR_HELPER}")"

  echo "{\"text\":\"\",\"tooltip\":\"${TOOLTIP//\"/\\\"}\"}"
fi
