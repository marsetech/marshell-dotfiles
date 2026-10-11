-- lua/plugins/ui/statusline.lua

-- ============================================================================
-- Dependencies
-- ============================================================================

vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

local file_icons = require("mini.icons")
local lualine = require("lualine")
local pywal = require("lib.pywal")

-- ============================================================================
-- Constants
-- ============================================================================

local COLORSCHEME = "pywal"

-- Custom statusline icons
local MODE_ICONS = {
  n = "\u{f121} ",
  i = "\u{f11c} ",
  v = "\u{f0168} ",
  V = "\u{f0168} ",
  ["\22"] = "\u{f0168} ",
  c = "\u{f120} ",
  R = "\u{f044} ",
  t = "\u{f120} ",
}

local MODE_NAMES = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "VISUAL LINE",
  ["\22"] = "VISUAL BLOCK",
  c = "COMMAND",
  R = "REPLACE",
  t = "TERMINAL",
}

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
-- Components
-- ============================================================================

local function mode_component()
  local mode = vim.api.nvim_get_mode().mode

  return string.format(
    "%s %s",
    MODE_ICONS[mode] or "\u{f059} ",
    MODE_NAMES[mode] or mode:upper()
  )
end

local function filetype_component()
  local filetype = vim.bo.filetype

  if filetype == "" then
    return ""
  end

  local icon = file_icons.get("filetype", filetype)

  return icon .. " " .. filetype
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
        left = "",
        right = "",
      },

      globalstatus = true,
    },

    sections = {
      lualine_a = {
        {
          mode_component,
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
        filetype_component,
      },

      lualine_z = {
        {
          "location",
          left_padding = 2,
        },
      },
    },
  }
end

-- ============================================================================
-- Colorscheme Integration
-- ============================================================================

local function refresh_theme()
  if vim.g.colors_name ~= COLORSCHEME then
    return
  end

  local ok, theme = pcall(create_theme)

  if not ok then
    vim.notify(
      "Failed to update Lualine Pywal theme: " .. tostring(theme),
      vim.log.levels.ERROR
    )
    return
  end

  lualine.setup({
    options = {
      theme = theme,
    },
  })

  lualine.refresh()
end

-- ============================================================================
-- Initialization
-- ============================================================================

lualine.setup(create_config())

local group = vim.api.nvim_create_augroup(
  "LualinePywalTheme",
  { clear = true }
)

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  pattern = COLORSCHEME,
  callback = refresh_theme,
})
