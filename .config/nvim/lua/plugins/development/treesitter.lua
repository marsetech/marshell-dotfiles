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

-- ============================================================================
-- Initialization
-- ============================================================================
local group = vim.api.nvim_create_augroup("MarshellTreesitter", {
  clear = true,
})

local function start_treesitter(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_is_loaded(buf) then
    return
  end

  pcall(vim.treesitter.start, buf)
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(event)
    start_treesitter(event.buf)
  end,
})

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
}):await(function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    start_treesitter(buf)
  end
end)
