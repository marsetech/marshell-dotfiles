vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal tabstop=2 shiftwidth=2 expandtab",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.hl.on_yank()
  end
})
