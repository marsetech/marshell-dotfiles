-- Snacks plugins entrypoint

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/folke/snacks.nvim",

  -- Dependencies
  "https://github.com/echasnovski/mini.icons",
})

local ui = require("plugins.ui")
local navigation = require("plugins.navigation")

-- ============================================================================
-- Configuration
-- ============================================================================
require("snacks").setup({
  dashboard = ui.dashboard,
  file_browser = navigation.file_browser,
  file_picker = navigation.file_picker,
})
