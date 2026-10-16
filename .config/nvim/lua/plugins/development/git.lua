-- lua/plugins/development/github.lua

-- ============================================================================
-- Configuration
-- ============================================================================
local function create_config()
  return {
    enabled = true,
  }
end

-- ============================================================================
-- Keymapping
-- ============================================================================
-- Lazygit
vim.keymap.set("n", "<leader>lg", function()
  Snacks.lazygit()
end, {
  desc = "Open Lazygit",
})

vim.keymap.set("n", "<leader>gl", function()
  Snacks.lazygit.log_file()
end, {
  desc = "Open Lazygit Log",
})

-- git integration
vim.keymap.set("n", "<leader>gr", function()
  Snacks.picker.gh_pr()
end, {
  desc = "Open GitHub Pull Requests",
})

vim.keymap.set("n", "<leader>gi", function()
  Snacks.picker.gh_issue()
end, {
  desc = "Open GitHub Issues",
})

-- ============================================================================
-- Initialization
-- ============================================================================
return create_config()
