return {
  polkit_manager = "pgrep -x polkit-gnome-au || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &",
  clipboard_services = {
    "pgrep -x wl-paste || wl-paste --type text --watch cliphist store &",
    "pgrep -x wl-paste || wl-paste --type image --watch cliphist store &"
  },
}
