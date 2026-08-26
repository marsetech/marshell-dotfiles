---- MY PROGRAMS ----------------------------------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"

local mainMod     = "SUPER" -- Sets "Windows" key as main modifier

---- KEYBINDINGS ----------------------------------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
