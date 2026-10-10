-- ============================================================================
-- Paths Requirement
-- ============================================================================
require("core")
require("plugins")

-- ============================================================================
-- Colorscheme Loading
-- ============================================================================
vim.cmd.colorscheme("pywal")

-- Reload the colorscheme whenever Pywal updates its palette.
require("lib.pywal").watch(function()
  vim.cmd.colorscheme("pywal")
end)
