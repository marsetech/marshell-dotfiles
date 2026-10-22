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
    menu = {
      border = "rounded",
      winblend = 0,
      max_height = 8,
      min_width = 36,
      scrollbar = false,

      draw = {
        padding = 1,
        gap = 1,

        columns = {
          { "kind_icon" },
          { "label",    gap = 1 },
          { "kind" },
        },
      },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 400,

      window = {
        border = "rounded",
        winblend = 10,
        max_width = 60,
        max_height = 15,
        scrollbar = false,
      },
    },

    ghost_text = {
      enabled = true,
    },
  },
})
