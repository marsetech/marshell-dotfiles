-- lua/plugins/lsp/lspconfig.lua

-- ============================================================================
-- Dependencies
-- ============================================================================

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

-- ============================================================================
-- Initialization
-- ============================================================================

vim.lsp.enable({
  "lua_ls",
  "bashls",
  "clangd",
  "cssls",
  "html",
  "jdtls",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "tinymist",
  "vtsls",
})

-- ============================================================================
-- Configuration
-- ============================================================================

-- Lua language server
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "Snacks" },
      },
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- C/C++ language server
vim.lsp.config("clangd", {})

-- ============================================================================
-- Keymaps
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("MarshellLspKeymaps", {
    clear = true,
  }),
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gd", function()
      Snacks.picker.lsp_definitions()
    end, vim.tbl_extend("force", opts, {
      desc = "Goto Definition",
    }))

    vim.keymap.set("n", "gD", function()
      Snacks.picker.lsp_declarations()
    end, vim.tbl_extend("force", opts, {
      desc = "Goto Declaration",
    }))

    vim.keymap.set("n", "gr", function()
      Snacks.picker.lsp_references()
    end, vim.tbl_extend("force", opts, {
      desc = "References",
      nowait = true,
    }))

    vim.keymap.set("n", "gI", function()
      Snacks.picker.lsp_implementations()
    end, vim.tbl_extend("force", opts, {
      desc = "Goto Implementation",
    }))
  end,
})
