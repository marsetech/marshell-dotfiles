local settings = require("shared.libs.window_rules_helper")

---- Graphical Editors -----------------------------------
local editors = {
  "code-oss",
  "[Cc]ode",
  "dev.zed.Zed",
  "code-url-handler",
  "code-insiders-url-handler",
}

settings.window_group({
  name = "graphical_editors",
  match = {
    class = editors,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.coding,
  }
})

---- Graphical Editors -----------------------------------
local terminal = {
  "kitty",
  "ghostty",
  "alacritty",
  "foot",
  "ghost",
}

settings.window_group({
  name = "terminal_emulators",
  match = {
    class = terminal,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.terminal,
  }
})

settings.window_group({
  name = "system_update",
  match = {
    class = terminal,
    title = ".*System Update.*",
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
  }
})
