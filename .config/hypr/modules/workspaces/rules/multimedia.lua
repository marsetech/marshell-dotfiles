local settings = require("shared.libs.window_rules_helper")

---- Video Player -----------------------------------
local video_player = {
  ".*mpv.*",
  "io.github.celluloid_player.Celluloid",
  ".*vlc.*",
  "smplayer",
}

settings.window_group({
  name = "video_viewer",
  match = {
    class = video_player,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.small,
  }
})

---- Image Viewer -----------------------------------
local image_viewer = {
  "(com\\.gabm\\.)?satty",
  "imv",
  "feh",
  "gwenview",
  "eog",
}

settings.window_group({
  name = "image_viewer",
  match = {
    class = image_viewer,
  },
  rules = {
    settings.opacity.system,
    settings.behaviour.floating,
    settings.size.default,
  }
})

---- Music Player -----------------------------------
local music_player = {
  "[Ss]potify",
  "[Nn]cspot",
}

settings.window_group({
  name = "music_player",
  match = {
    class = music_player,
  },
  rules = {
    settings.opacity.system,
    settings.workspace.music,
  }
})

---- Screen Recording -----------------------------------
local screen_recorder = {
  "com.obsproject.Studio",
}

settings.window_group({
  name = "screen_recording",
  match = {
    class = screen_recorder,
  },
  rules = {
    settings.opacity.system,
    -- settings.behaviour.floating,
    settings.size.small,
    settings.workspace.screen_recording,
  }
})
