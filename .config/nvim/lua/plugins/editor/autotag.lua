-- lua/plugins/editor/autotag.lua

-- ============================================================================
-- Dependencies
-- ============================================================================

vim.pack.add({
  "https://github.com/windwp/nvim-ts-autotag",
})

-- ============================================================================
-- Initialization
-- ============================================================================

require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
})
