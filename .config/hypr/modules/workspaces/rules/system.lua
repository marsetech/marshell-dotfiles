local settings = require("shared.libs.window_rules_helper")

---- Audio Multimedia -----------------------------------
local audio_media_utils = {
  -- GUI programs
  "blueman-manager",
  "org.pulseaudio.pavucontrol",
  "com.github.rafostar.Clapper",

  -- TUI programs
  "wiremix",
  "bluetui",
}

settings.window_group({
  name = "audio_media_utils",
  match = {
    class = audio_media_utils,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
    settings.workspace.music,
  }
})

---- Network Tooling -----------------------------------
local network_managers = {
  "nm-applet",
  "nm-connection-editor",
}

settings.window_group({
  name = "network_tools",
  match = {
    class = network_managers,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
  }
})

---- System Authentication -----------------------------------
local system_auth_portals = {
  "org.kde.polkit-kde-authentication-agent-1",
  "polkit-gnome-authentication-agent-1",
  "org.freedesktop.impl.portal.desktop.(gtk|hyprland)",
  "xdg-desktop-portal-(gtk|hyprland)",
}

settings.window_group({
  name = "system_portals",
  match = {
    class = system_auth_portals,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
    settings.workspace.coding,
  }
})

---- System Default ----------------------------------------
hl.window_rule({
  name = "suppress-maximize-events",
  match = {
    class = ".*",
  },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})
