return {
  status_bar_reloader = "~/.config/waybar/scripts/reload.sh",
  system_power_menu = "~/.config/rofi/modules/system_powermenu/main.sh",

  bluetooth_reloader = "~/.config/hypr/scripts/system/bluetooth-restart.service.sh",
  audio_control_center = "~/.config/hypr/scripts/system/audio-controller.service.sh",

  lockscreen_page = "pgrep -x hyprlock || hyprlock",

  polkit_manager = "pgrep -x polkit-gnome-au || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &",

  clipboard_services = {
    "pgrep -x wl-paste || wl-paste --type text --watch cliphist store &",
    "pgrep -x wl-paste || wl-paste --type image --watch cliphist store &"
  },
}
