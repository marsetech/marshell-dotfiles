local input = require("shared.config.modifiers")
local launcher = require("shared.config.launcher")
local applications = require("shared.config.applications")

hl.bind(input.primary_key .. " + RETURN", hl.dsp.exec_cmd(applications.terminal))
hl.bind(input.primary_key .. " + E", hl.dsp.exec_cmd(applications.file_manager))
hl.bind(input.primary_key .. " + B", hl.dsp.exec_cmd(applications.browser))
hl.bind(input.primary_key .. " + S", hl.dsp.exec_cmd(applications.music))
hl.bind(input.primary_key .. " + A", hl.dsp.exec_cmd(launcher.application_selector))
hl.bind(input.primary_key .. " + C", hl.dsp.exec_cmd(applications.editor))
hl.bind(input.primary_key .. " + O", hl.dsp.exec_cmd(applications.screen_recording))

hl.bind(input.secondary_key .. " + E", hl.dsp.exec_cmd(applications.root_file_manager))
