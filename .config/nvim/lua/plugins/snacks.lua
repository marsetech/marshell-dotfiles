-- Snacks plugins entrypoint

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local ui = require("plugins.ui")
local navigation = require("plugins.navigation")
local editor = require("plugins.editor")
local development = require("plugins.development")

-- ============================================================================
-- Configuration
-- ============================================================================
require("snacks").setup({
  dashboard = ui.dashboard,

  explorer = navigation.file_browser,
  picker = navigation.file_picker,

  bigfile = editor.bigfile_handler,
  scroll = editor.smooth_scrolling,

  lazygit = development.git
})
