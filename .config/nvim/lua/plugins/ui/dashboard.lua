-- lua/plugins/ui/dashboard.lua

-- ============================================================================
-- Constants
-- ============================================================================

local DASHBOARD_WIDTH = 70
local DASHBOARD_HEADER = [[
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████
]]

local DASHBOARD_TAGLINE = "Powered by Marshell"

-- ============================================================================
-- Highlights
-- ============================================================================

vim.api.nvim_set_hl(0, "SnacksDashboardTitle", {
  bold = true,
})

vim.api.nvim_set_hl(0, "SnacksDashboardKey", {
  bold = true,
})

-- ============================================================================
-- Dashboard Sections
-- ============================================================================

local function create_sections()
  return {
    -- Header
    {
      padding = 1,
      text = {
        DASHBOARD_HEADER,
        hl = "header",
      },
    },

    -- Tagline
    {
      padding = 1,
      align = "center",
      text = {
        DASHBOARD_TAGLINE,
        hl = "header",
      },
    },

    -- Builtin Actions
    {
      title = "Builtin Actions",
      indent = 2,
      padding = 1,

      {
        icon = " ",
        key = "n",
        desc = "New File",
        action = ":ene | startinsert",
      },
      {
        icon = " ",
        key = "f",
        desc = "Find File",
        action = ":lua Snacks.dashboard.pick('files')",
      },
      {
        icon = " ",
        key = "s",
        desc = "Find Text",
        action = ":lua Snacks.dashboard.pick('live_grep')",
      },
      {
        icon = " ",
        key = "q",
        desc = "Quit",
        action = ":qa",
      },
    },

    -- Recent Items
    {
      title = "Recent Projects",
      section = "projects",
      indent = 2,
      padding = 1,
    },
    {
      title = "Recent Files",
      section = "recent_files",
      indent = 2,
      padding = 1,
    },

    -- Maintenance Actions
    {
      title = "Maintenance Actions",
      indent = 2,
      padding = 2,

      {
        icon = " ",
        key = "c",
        desc = "Config",
        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
      },
    },
  }
end

-- ============================================================================
-- Dashboard Configuration
-- ============================================================================

local function create_config()
  return {
    enabled = true,
    width = DASHBOARD_WIDTH,
    sections = create_sections,
  }
end

-- ============================================================================
-- Initialization
-- ============================================================================

return create_config()
