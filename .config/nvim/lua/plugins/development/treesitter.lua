-- lua/plugins/development/treesitter.lua

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- ============================================================================
-- Configuration
-- ============================================================================
local treesitter = require("nvim-treesitter")

vim.filetype.add({
  pattern = {
    [".*%.conf"] = "hyprlang",
  },
})

treesitter.setup()

treesitter.install({
  "rust",
  "lua",
  "bash",
  "json",
  "html",
  "python",
  "java",
  "c",
  "cpp",
  "css",
  "scss",
  "typescript",
  "markdown",
  "markdown_inline",
  "hyprlang",
  "typst",
})

-- ============================================================================
-- Initialization
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MarshellTreesitter", {
    clear = true,
  }),
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})
