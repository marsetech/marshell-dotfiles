#!/usr/bin/env bash
set -euo pipefail

# -------------------------
# Global variables
# -------------------------
ROFI_CONFIG="${ROFI_CONFIG:-$HOME/.config/rofi/config/layouts/utils-selector.rasi}"
SESSION_TYPE="$XDG_SESSION_TYPE"

ENABLED_COLOR="#A3BE8C"
DISABLED_COLOR="#D35F5E"

SIGNAL_ICONS=("󰤟" "󰤢" "󰤥" "󰤨")
SECURED_SIGNAL_ICONS=("󰤡" "󰤤" "󰤧" "󰤪")

WIFI_CONNECTED_ICON=" "
ETHERNET_CONNECTED_ICON=" "

# -------------------------
# Helper functions
# -------------------------
get_status() {
  if nmcli -t -f TYPE,STATE device status | grep -q 'ethernet:connected'; then
    local status_icon="󰈀"
    local status_color="$ENABLED_COLOR"
  elif nmcli -t -f TYPE,STATE device status | grep -q 'wifi:connected'; then
    local wifi_info
    wifi_info=$(nmcli -t -f "IN-USE,SIGNAL,SECURITY,SSID" device wifi list --rescan no | grep '\*')
    if [[ -n "$wifi_info" ]]; then
      IFS=: read -r in_use signal security ssid <<< "$wifi_info"
      local signal_level=$((signal / 25))
      local signal_icon="${SIGNAL_ICONS[3]}"
      if [[ "$signal_level" -lt "${#SIGNAL_ICONS[@]}" ]]; then
        signal_icon="${SIGNAL_ICONS[$signal_level]}"
      fi
      [[ "$security" =~ WPA|WEP ]] && signal_icon="${SECURED_SIGNAL_ICONS[$signal_level]}"
      status_icon="$signal_icon"
      status_color="$ENABLED_COLOR"
    else
      status_icon=""
      status_color="$DISABLED_COLOR"
    fi
  else
    status_icon=""
    status_color="$DISABLED_COLOR"
  fi

  if [[ "$SESSION_TYPE" == "wayland" ]]; then
    echo "<span color=\"$status_color\">$status_icon</span>"
  else
    echo "%{F$status_color}$status_icon%{F-}"
  fi
}

# -------------------------
# Wi-Fi management
# -------------------------
manage_wifi() {
  local tmpfile
  tmpfile=$(mktemp)
  nmcli --terse --fields "IN-USE,SIGNAL,SECURITY,SSID" device wifi list > "$tmpfile"

  local ssids=()
  local formatted_ssids=()
  local active_ssid=""

  while IFS=: read -r in_use signal security ssid; do
    [[ -z "$ssid" ]] && continue

    local signal_level=$((signal / 25))
    local signal_icon="${SIGNAL_ICONS[3]}"
    if [[ "$signal_level" -lt "${#SIGNAL_ICONS[@]}" ]]; then
      signal_icon="${SIGNAL_ICONS[$signal_level]}"
    fi
    [[ "$security" =~ WPA|WEP ]] && signal_icon="${SECURED_SIGNAL_ICONS[$signal_level]}"

    local formatted="$signal_icon $ssid"
    [[ "$in_use" == "*" ]] && { active_ssid="$ssid"; formatted="$WIFI_CONNECTED_ICON $formatted"; }

    ssids+=("$ssid")
    formatted_ssids+=("$formatted")
  done < "$tmpfile"

  local chosen_network
  chosen_network=$(printf "%s\n" "${formatted_ssids[@]}" | rofi -dmenu -i -selected-row 0 -p "Wi-Fi SSID: " -config "$ROFI_CONFIG")
  [[ -z "$chosen_network" ]] && { rm "$tmpfile"; return; }

  local chosen_index
  for i in "${!formatted_ssids[@]}"; do
    [[ "${formatted_ssids[$i]}" == "$chosen_network" ]] && { chosen_index="$i"; break; }
  done

  local chosen_id="${ssids[$chosen_index]}"
  local action
  if [[ "$chosen_id" == "$active_ssid" ]]; then
    action="  Disconnect"
  else
    action="󰸋  Connect"
  fi
  action=$(echo -e "$action\n  Forget" | rofi -dmenu -p "Action: " -config "$ROFI_CONFIG")

  case "$action" in
    "󰸋  Connect")
      local saved_connections
      saved_connections=$(nmcli -g NAME connection show)
      if echo "$saved_connections" | grep -Fxq "$chosen_id"; then
        nmcli connection up id "$chosen_id" && notify-send "Connected" "You are now connected to $chosen_id"
      else
        local wifi_password
        wifi_password=$(rofi -dmenu -p "Password: " -password -config "$ROFI_CONFIG")
        nmcli device wifi connect "$chosen_id" password "$wifi_password" && notify-send "Connected" "You are now connected to $chosen_id"
      fi
      ;;
    "  Disconnect")
      nmcli device disconnect wlan0 && notify-send "Disconnected" "Disconnected from $chosen_id"
      ;;
    "  Forget")
      nmcli connection delete id "$chosen_id" && notify-send "Forgotten" "Network $chosen_id forgotten"
      ;;
  esac

  rm "$tmpfile"
}

# -------------------------
# Ethernet management
# -------------------------
manage_ethernet() {
  local eth_devices
  eth_devices=$(nmcli device status | grep ethernet | awk '{print $1}')
  [[ -z "$eth_devices" ]] && { notify-send "Error" "Ethernet device not found"; return; }

  local eth_list=()
  for dev in $eth_devices; do
    local dev_status
    dev_status=$(nmcli device status | grep "$dev" | awk '{print $3}')
    [[ "$dev_status" == "connected" ]] && eth_list+=("$ETHERNET_CONNECTED_ICON$dev") || eth_list+=("$dev")
  done

  local chosen_device
  chosen_device=$(printf "%s\n" "${eth_list[@]}" | rofi -dmenu -i -p "Select Ethernet device: " -config "$ROFI_CONFIG")
  [[ -z "$chosen_device" ]] && return

  chosen_device=${chosen_device#$ETHERNET_CONNECTED_ICON}
  local device_status
  device_status=$(nmcli device status | grep "$chosen_device" | awk '{print $3}')

  case "$device_status" in
    connected) nmcli device disconnect "$chosen_device" && notify-send "Disconnected" "Disconnected from $chosen_device" ;;
    disconnected) nmcli device connect "$chosen_device" && notify-send "Connected" "Connected to $chosen_device" ;;
    *) notify-send "Error" "Cannot determine action for $chosen_device" ;;
  esac
}

# -------------------------
# Main menu
# -------------------------
main_menu() {
  # Ensure NetworkManager is running
  if ! pgrep -x "NetworkManager" > /dev/null; then
    echo -n "Root Password: "
    read -s password
    echo "$password" | sudo -S systemctl start NetworkManager
  fi

  local wifi_status
  wifi_status=$(nmcli -fields WIFI g)
  local wifi_toggle wifi_toggle_cmd manage_wifi_btn=""
  if [[ "$wifi_status" =~ "enabled" ]]; then
    wifi_toggle="󱛅  Disable Wi-Fi"
    wifi_toggle_cmd="off"
    manage_wifi_btn="󱓥 Manage Wi-Fi"
  else
    wifi_toggle="󱚽  Enable Wi-Fi"
    wifi_toggle_cmd="on"
  fi

  local options="$wifi_toggle"
  [[ -n "$manage_wifi_btn" ]] && options+=$'\n'"$manage_wifi_btn"
  options+=$'\n󱓥 Manage Ethernet'

  local choice
  choice=$(echo -e "$options" | rofi -dmenu -i -p " Network:" -config "$ROFI_CONFIG")

  case "$choice" in
    "$wifi_toggle")
      nmcli radio wifi "$wifi_toggle_cmd" ;;
    "󱓥 Manage Wi-Fi")
      manage_wifi ;;
    "󱓥 Manage Ethernet")
      manage_ethernet ;;
  esac
}

# -------------------------
# Entrypoint
# -------------------------
main_menu "$@"
