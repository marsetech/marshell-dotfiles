-- lua/plugins/navigation/file-browser.lua

-- ============================================================================
-- Configuration
-- ============================================================================

local function create_config()
  return {
    enabled = true,
  }
end

-- ============================================================================
-- Keymaps
-- ============================================================================

vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.pick("files")
end, {
  desc = "Find Files",
})

vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, {
  desc = "Recent Files",
})

vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, {
  desc = "Buffers",
})

vim.keymap.set("n", "<leader>fg", function()
  Snacks.picker.grep()
end, {
  desc = "Grep Files",
})

-- ============================================================================
-- Initialization
-- ============================================================================

return create_config()
