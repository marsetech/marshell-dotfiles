-- lua/plugins/editor/todo-comments.lua

-- ============================================================================
-- Dependencies
-- ============================================================================

vim.pack.add({
  "https://github.com/folke/todo-comments.nvim",

  -- Dependencies
  "https://github.com/nvim-lua/plenary.nvim"
})

-- ============================================================================
-- Initialization
-- ============================================================================

require("todo-comments").setup()
