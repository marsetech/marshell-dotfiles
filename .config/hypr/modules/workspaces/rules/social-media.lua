local settings = require("shared.libs.window_rules_helper")

---- Graphical Editors -----------------------------------
local social_networks = {
  "vesktop",
  "discord",
  "org.telegram.desktop",
  "teams",
  "[Ss]ignal",
}

settings.window_group({
  name = "social_media",
  match = {
    class = social_networks,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.social,
  }
})
