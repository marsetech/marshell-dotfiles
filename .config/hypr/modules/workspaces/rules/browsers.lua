local settings = require("shared.libs.window_rules_helper")

---- Chromium based Browsers ------------------------------
local chromium_based_browsers = {
  "(google-)?[cC]hrom(e|ium)",
  "Microsoft-edge",
  "Vivaldi-stable",
  "helium",
  "[bB]rave-(browser|origin|origin-nightly)",
}

settings.window_group({
  name = "chromium_browser",
  match = {
    class = chromium_based_browsers,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.web,
  }
})

---- Firefox based Browsers ---------------------------
local firefox_based_browsers = {
  "[fF]irefox",
  "librewolf",
  "zen",
}

settings.window_group({
  name = "firefox_browser",
  match = {
    class = firefox_based_browsers,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.web,
  }
})

---- Firefox based Browsers ---------------------------
local pip_browser = {
  "Picture in picture",
}

settings.window_group({
  name = "picture_in_picture",
  match = {
    title = pip_browser,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.web,
    settings.behaviour.floating,
    settings.size.small,
  }
})

---- Firefox based Browsers ---------------------------
local browser_extensions = {
  "Bitwarden",
}

settings.window_group({
  name = "browser_extensions",
  match = {
    title = browser_extensions,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.web,
    settings.behaviour.floating,
  }
})
