local config = {}

config.applications = require("shared.config.applications")
config.launcher = require("shared.config.launcher")
config.services = require("shared.config.services")
config.workspaces = require("shared.config.workspaces")

return config
