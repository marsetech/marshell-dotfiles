-- Snacks plugins entrypoint

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/folke/snacks.nvim",
})

local ui = require("plugins.ui")
local navigation = require("plugins.navigation")

-- ============================================================================
-- Configuration
-- ============================================================================
require("snacks").setup({
  dashboard = ui.dashboard,
  explorer = navigation.file_browser,
  picker = navigation.file_picker,
})
