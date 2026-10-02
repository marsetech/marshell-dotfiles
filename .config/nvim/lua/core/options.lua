-- Editor's numbers settings
vim.opt.nu = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indentation settings
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Behaviour settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.wrap = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.clipboard:append("unnamedplus")
vim.opt.isfname:append("@-@")
vim.opt.scrolloff = 8
vim.opt.cmdheight = 0

-- History settings
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Terminal settings
vim.opt.termguicolors = true
vim.opt.splitright = true
-- vim.opt.winborder = "rounded"
vim.g.have_nerd_font = true
