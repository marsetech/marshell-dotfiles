local wallpaper_bootstrap = require("shared.libs.bootstrap_wallpaper")
local services = require("shared.config.services")

local current_wallpaper = wallpaper_bootstrap.get_wallpaper()

-- ════ Autostart ════════════════════════════════════════════════
hl.on("hyprland.start", function()
  hl.exec_cmd("awww-daemon")
  if current_wallpaper and current_wallpaper ~= "" then
    hl.exec_cmd("awww img '" .. current_wallpaper .. "'")
  end

  for _, cmd in ipairs(services.clipboard_services) do
    hl.exec_cmd(cmd)
  end

  hl.exec_cmd(services.polkit_manager)

  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("trash-empty 30")
end)
