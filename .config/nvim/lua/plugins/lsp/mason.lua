-- lua/plugins/lsp/mason.lua

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

-- ============================================================================
-- Configuration
-- ============================================================================
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
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
  },

  -- LSP servers are enabled in lspconfig.lua.
  automatic_enable = false,
})

require("mason-tool-installer").setup({
  ensure_installed = {
    -- Lua
    "stylua",

    -- JavaScript / TypeScript
    "prettier",
    "eslint_d",

    -- Python
    "ruff",
    "black",

    -- Shell
    "shfmt",
    "shellcheck",
  },

  auto_update = false,
  run_on_start = true,
})
