-- Snacks plugins entrypoint

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/folke/snacks.nvim",

  -- Dependencies
  "https://github.com/echasnovski/mini.icons",
})


-- ============================================================================
-- Configuration
-- ============================================================================
require("snacks").setup({
  dashboard = require("plugins.ui.dashboard"),
})
