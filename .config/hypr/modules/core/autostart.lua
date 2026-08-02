local wallpaper_bootstrap = require("shared.libs.bootstrap_wallpaper")

local current_wallpaper = wallpaper_bootstrap.get_wallpaper()

-- ════ Autostart ════════════════════════════════════════════════
hl.on("hyprland.start", function()
  hl.exec_cmd("awww-daemon")
  if current_wallpaper and current_wallpaper ~= "" then
    hl.exec_cmd("awww img '" .. current_wallpaper .. "'")
  end

  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("trash-empty 30")
end)
