-- lua/lib/pywal.lua

local M = {}

-- ============================================================================
-- Constants
-- ============================================================================

local WAL_DIRECTORY = vim.fn.expand("~/.cache/wal")
local WAL_FILENAME = "colors-hyprland.lua"
local WAL_FILE = WAL_DIRECTORY .. "/" .. WAL_FILENAME

-- ============================================================================
-- Color Utilities
-- ============================================================================

function M.to_hex(color)
  local red, green, blue = color:match(
    "rgba%((%d+),(%d+),(%d+),[%d%.]+%)"
  )

  if not red then
    return color
  end

  return string.format(
    "#%02x%02x%02x",
    tonumber(red),
    tonumber(green),
    tonumber(blue)
  )
end

-- ============================================================================
-- Theme
-- ============================================================================

function M.load()
  return dofile(WAL_FILE)
end

function M.colors()
  local wal = M.load()

  return {
    color0 = M.to_hex(wal.color0),
    color1 = M.to_hex(wal.color1),
    color2 = M.to_hex(wal.color2),
    color3 = M.to_hex(wal.color3),
    color4 = M.to_hex(wal.color4),
    color5 = M.to_hex(wal.color5),
    color6 = M.to_hex(wal.color6),
    color7 = M.to_hex(wal.color7),
    foreground = M.to_hex(wal.foreground),
    background = M.to_hex(wal.background),
  }
end

-- ============================================================================
-- Watcher
-- ============================================================================

function M.watch(callback, delay)
  local watcher = vim.uv.new_fs_event()

  if not watcher then
    return
  end

  watcher:start(WAL_DIRECTORY, {}, function(error, filename)
    if error or filename ~= WAL_FILENAME then
      return
    end

    vim.defer_fn(function()
      vim.schedule(function()
        callback()
      end)
    end, delay or 200)
  end)

  local group = vim.api.nvim_create_augroup(
    "PywalWatcher",
    { clear = true }
  )

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      watcher:stop()
      watcher:close()
    end,
  })
end

return M
