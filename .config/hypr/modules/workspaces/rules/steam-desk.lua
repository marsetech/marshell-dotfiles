local settings = require("shared.libs.window_rules_helper")

---- Gaming suite -----------------------------------
local gaming_suite = {
  "[Ss]team",
  "steamwebhelper",
}

settings.window_group({
  name = "gaming_desktop",
  match = {
    class = gaming_suite,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
  }
})
