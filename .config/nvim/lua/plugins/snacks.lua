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

-- ============================================================================
-- Configuration
-- ============================================================================
require("snacks").setup({
  dashboard = ui.dashboard,
})
