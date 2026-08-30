local input = require("shared.config.modifiers")
local services = require("shared.config.services")
local launcher = require("shared.config.launcher")

hl.bind(input.primary_key .. " + Q", hl.dsp.window.close())
hl.bind(input.primary_key .. " + F", hl.dsp.window.fullscreen())
hl.bind(input.primary_key .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(input.primary_key .. " + P", hl.dsp.window.pseudo())
hl.bind(input.secondary_key .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(input.tertiary_key .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only

hl.bind(input.primary_key .. " + W", hl.dsp.exec_cmd(launcher.wallpaper_engine_switcher))
hl.bind(input.primary_key .. " + V", hl.dsp.exec_cmd(launcher.clipboard_manager))
hl.bind(input.primary_key .. " + R", hl.dsp.exec_cmd(launcher.utility_selector))

hl.bind(input.primary_key .. " + M", hl.dsp.exec_cmd(services.system_power_menu))
hl.bind(input.primary_key .. " + L", hl.dsp.exec_cmd(services.lockscreen_page))
hl.bind(input.secondary_key .. " + W", hl.dsp.exec_cmd(services.status_bar_reloader))
hl.bind(input.secondary_key .. " + B", hl.dsp.exec_cmd(services.bluetooth_reloader))
