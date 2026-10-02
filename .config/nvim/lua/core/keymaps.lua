local function opts_desc(desc)
    return {
        silent = true,
        desc = desc,
    }
end

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
vim.keymap.set("x", "p", [["_dP]], opts_desc("Paste over selection without yank"))
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts_desc("Delete without yank"))

-- Selection and indentation
vim.keymap.set({ "n", "v" }, "<", "<gv", opts_desc("Shift selection left and keep selection"))
vim.keymap.set({ "n", "v" }, ">", ">gv", opts_desc("Shift selection right and keep selection"))

-- Line editing
vim.keymap.set("n", "J", "mzJ`z", opts_desc("Join lines without moving cursor"))
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", opts_desc("Move lines down"))
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", opts_desc("Move lines up"))

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts_desc("Move down in buffer with cursor centered"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts_desc("Move up in buffer with cursor centered"))

-- Search
vim.keymap.set("n", "n", "nzzzv", opts_desc("Next search result with cursor centered"))
vim.keymap.set("n", "N", "Nzzzv", opts_desc("Previous search result with cursor centered"))
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>", opts_desc("Clear search highlighting"))

-- Search and replace
vim.keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    opts_desc("Replace word under cursor globally")
)

-- Files
vim.keymap.set(
    "n",
    "<leader>x",
    "<cmd>!chmod +x %<CR>",
    opts_desc("Make current file executable")
)

-- Configuration
vim.keymap.set(
    "n",
    "<leader>re",
    "<cmd>restart<CR>",
    opts_desc("Restart Neovim configuration")
)

-- Undo tree
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, opts_desc("Toggle built-in undo tree"))

-- Buffers
vim.keymap.set("n", "<A-Tab>", "<cmd>BufferLineCycleNext<CR>", opts_desc("Next buffer"))
vim.keymap.set("n", "<C-Q>", "<cmd>bdelete<CR>", opts_desc("Delete buffer"))
