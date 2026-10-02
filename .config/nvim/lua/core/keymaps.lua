local function opts_desc(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- Clipboard Management
vim.keymap.set("x", "p", [["_dP]], opts_desc("Paste over selection without yank"))
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts_desc("Delete without yank"))

-- Editor movement
vim.keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", opts_desc("Move lines down"))
vim.keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", opts_desc("Move lines up"))

vim.keymap.set({ "n", "v" }, "<", "<gv", opts_desc("Shift selection left and keep selection"))
vim.keymap.set({ "n", "v" }, ">", ">gv", opts_desc("Shift selection right and keep selection"))

vim.keymap.set("n", "J", "mzJ`z", opts_desc("Join lines without moving cursor"))

vim.keymap.set("n", "n", "nzzzv", opts_desc("Next search result with cursor centered"))
vim.keymap.set("n", "N", "Nzzzv", opts_desc("Previous search result with cursor centered"))

vim.keymap.set("n", "<C-d>", "<C-d>zz", opts_desc("Move down in buffer with cursor centered"))
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts_desc("Move up in buffer with cursor centered"))

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  opts_desc("Replace word cursor globally"))
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", opts_desc("Makes file executable"))

vim.keymap.set("n", "<leader>re", "<cmd>restart<cr>", opts_desc("Restart Neovim configuration"))
vim.keymap.set("n", "<leader>X", function()
  vim.cmd.packadd("nvim.undotree")
  require("undotree").open()
end, opts_desc("Toggle Builtin Undotree"))

-- ===== Buffers =====
vim.keymap.set("n", "<A-Tab>", ":BufferLineCycleNext<CR>", opts_desc("Next buffer"))
vim.keymap.set("n", "<C-Q>", ":bdelete<CR>", opts_desc("Delete buffer"))

-- ===== Toggle highlighting =====
vim.keymap.set("n", "<C-c>", ":nohl<CR>", opts_desc("Toggle hlsearch"))



vim.keymap.set("n", "<leader>m", ":PeekOpen<CR>",
  vim.tbl_extend("force", opts_desc("Markdown Preview"), { buffer = true }))

--vim.api.nvim_create_autocmd("BufEnter", {
--	pattern = "*.lua",
--	callback = function()
--		local fname = vim.api.nvim_buf_get_name(0)
--		local util = require("lspconfig.util")
--		local root = util.find_git_ancestor(fname)
--			or util.root_pattern(".git")(fname)
--			or util.root_pattern("lua")(fname)
--			or vim.fn.fnamemodify(fname, ":p:h")
--
--		-- Controlla se il root è diverso da quello attuale
--		local clients = vim.lsp.get_clients({ name = "lua_ls" })
--		if root and (#clients == 0 or root ~= clients[1].config.root_dir) then
--			-- Stoppa eventuali client attivi
--			for _, client in ipairs(clients) do
--				vim.lsp.stop_client(client.id)
--			end
--			-- Cambia directory e riavvia lua_ls
--			vim.cmd("cd " .. root)
--			vim.cmd("LspStart lua_ls")
--			print("📂 Root LSP cambiata in: " .. root)
--		end
--	end,
--})
