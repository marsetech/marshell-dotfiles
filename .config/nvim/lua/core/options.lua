-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Editing
vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

-- Search
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Files and persistence
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Windows and splits
vim.opt.splitright = true

-- Interface
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.guicursor = ""

-- Window borders
-- vim.opt.winborder = "rounded"
