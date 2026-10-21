-- plugins/completition/blink.lua

-- ============================================================================
-- Dependencies
-- ============================================================================
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/rafamadriz/friendly-snippets",
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
  },
})

-- ============================================================================
-- Snippets
-- ============================================================================
require("luasnip.loaders.from_vscode").lazy_load()

-- ============================================================================
-- Configuration
-- ============================================================================
require("blink.cmp").setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },

    menu = {
      auto_show = true,
    },
  },

  snippets = {
    preset = "luasnip",
  },

  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },

  fuzzy = {
    implementation = "lua",
  },
})
