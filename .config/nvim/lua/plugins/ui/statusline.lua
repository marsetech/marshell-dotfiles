-- lua/plugins/ui/statusline.lua

-- ============================================================================
-- Dependencies
-- ============================================================================

vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",

  -- Dependencies
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local lualine = require("lualine")
local pywal = require("lib.pywal")

-- ============================================================================
-- Constants
-- ============================================================================

local PYWAL_RELOAD_DELAY = 200

-- ============================================================================
-- Lualine Theme
-- ============================================================================

local function create_theme()
  local wal = pywal.colors()

  return {
    normal = {
      a = {
        fg = wal.color0,
        bg = wal.color5,
        gui = "bold",
      },

      b = {
        fg = wal.foreground,
        bg = wal.background,
      },

      c = {
        fg = wal.foreground,
        bg = wal.background,
      },
    },

    insert = {
      a = {
        fg = wal.color0,
        bg = wal.color4,
        gui = "bold",
      },
    },

    visual = {
      a = {
        fg = wal.color0,
        bg = wal.color6,
        gui = "bold",
      },
    },

    replace = {
      a = {
        fg = wal.color0,
        bg = wal.color1,
        gui = "bold",
      },
    },

    command = {
      a = {
        fg = wal.color0,
        bg = wal.color3,
        gui = "bold",
      },
    },

    inactive = {
      a = {
        fg = wal.color7,
        bg = wal.color0,
      },

      b = {
        fg = wal.color7,
        bg = wal.color0,
      },

      c = {
        fg = wal.color7,
        bg = wal.color0,
      },
    },
  }
end

-- ============================================================================
-- Lualine Configuration
-- ============================================================================

local function create_config()
  return {
    options = {
      theme = create_theme(),

      component_separators = "",

      section_separators = {
        left = "",
        right = "",
      },

      globalstatus = true,
    },

    sections = {
      lualine_a = {
        {
          "mode",
          separator = {
            left = "",
          },
          right_padding = 2,
        },
      },

      lualine_b = {
        {
          "filename",
          gui = "bold",
        },
        "branch",
      },

      lualine_c = {
        "%=",
      },

      lualine_x = {},

      lualine_y = {
        "filetype",
        "progress",
      },

      lualine_z = {
        {
          "location",
          separator = {
            right = "",
          },
          left_padding = 2,
        },
      },
    },

    inactive_sections = {
      lualine_a = {
        "filename",
      },

      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},

      lualine_z = {
        "location",
      },
    },

    tabline = {},
    extensions = {},
  }
end

-- ============================================================================
-- Pywal Watcher
-- ============================================================================

local function watch_pywal()
  pywal.watch(function()
    local ok, theme = pcall(create_theme)

    if not ok or not theme then
      return
    end

    lualine.setup({
      options = {
        theme = theme,
      },
    })

    lualine.refresh()
  end, PYWAL_RELOAD_DELAY)
end

-- ============================================================================
-- Initialization
-- ============================================================================

lualine.setup(create_config())
watch_pywal()
