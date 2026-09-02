local settings = require("shared.libs.window_rules_helper")

---- Appearance Tooling -----------------------------------
local appearance_tools = {
  "nwg-look",
  "kvantummanager",
  "qt5ct",
  "qt6ct",
}

settings.window_group({
  name = "theming_manager",
  match = {
    class = appearance_tools,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
  }
})
