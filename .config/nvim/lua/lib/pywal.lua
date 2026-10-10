-- lua/lib/pywal.lua

local M = {}

-- ============================================================================
-- Constants
-- ============================================================================

local WAL_DIRECTORY = vim.fn.expand("~/.cache/wal")
local WAL_FILENAME = "colors-hyprland.lua"
local WAL_FILE = WAL_DIRECTORY .. "/" .. WAL_FILENAME

local DEFAULT_DELAY = 200

-- ============================================================================
-- State
-- ============================================================================

local watcher
local debounce_timer
local watch_group
local generation = 0

-- ============================================================================
-- Color Utilities
-- ============================================================================

function M.to_hex(color)
  if type(color) ~= "string" then
    return color
  end

  local red, green, blue = color:match(
    "rgba%(%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*,[%d%.]+%)"
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
-- Palette
-- ============================================================================

function M.load()
  local ok, result = pcall(dofile, WAL_FILE)

  if not ok then
    error(
      ("Failed to load Pywal colors from %s: %s"):format(
        WAL_FILE,
        result
      ),
      2
    )
  end

  if type(result) ~= "table" then
    error("Pywal colors file must return a Lua table", 2)
  end

  return result
end

function M.colors()
  local wal = M.load()
  local colors = {}

  for index = 0, 15 do
    local key = "color" .. index

    if wal[key] then
      colors[key] = M.to_hex(wal[key])
    end
  end

  colors.foreground = M.to_hex(wal.foreground)
  colors.background = M.to_hex(wal.background)

  return colors
end

-- ============================================================================
-- Watcher
-- ============================================================================

function M.stop_watch()
  generation = generation + 1

  if watcher then
    watcher:stop()
    watcher:close()
    watcher = nil
  end

  if debounce_timer then
    debounce_timer:stop()
    debounce_timer:close()
    debounce_timer = nil
  end

  if watch_group then
    pcall(vim.api.nvim_del_augroup_by_id, watch_group)
    watch_group = nil
  end
end

function M.watch(callback, delay)
  M.stop_watch()

  local current_generation = generation
  local debounce_delay = delay or DEFAULT_DELAY

  watcher = vim.uv.new_fs_event()

  if not watcher then
    vim.notify(
      "Failed to create Pywal filesystem watcher",
      vim.log.levels.ERROR
    )
    return
  end

  debounce_timer = vim.uv.new_timer()

  if not debounce_timer then
    watcher:close()
    watcher = nil

    vim.notify(
      "Failed to create Pywal debounce timer",
      vim.log.levels.ERROR
    )
    return
  end

  local ok, err = watcher:start(
    WAL_DIRECTORY,
    {},
    function(watch_error, filename)
      if watch_error then
        vim.schedule(function()
          vim.notify(
            "Pywal watcher error: " .. watch_error,
            vim.log.levels.ERROR
          )
        end)
        return
      end

      -- A missing filename can occur with filesystem notifications.
      if filename and filename ~= WAL_FILENAME then
        return
      end

      debounce_timer:stop()

      debounce_timer:start(
        debounce_delay,
        0,
        vim.schedule_wrap(function()
          if current_generation ~= generation then
            return
          end

          -- Allow Pywal to finish writing the palette.
          local success, result = pcall(callback)

          if not success then
            vim.notify(
              "Failed to reload Pywal colors: " .. tostring(result),
              vim.log.levels.ERROR
            )
          end
        end)
      )
    end
  )

  if not ok then
    watcher:close()
    watcher = nil

    debounce_timer:close()
    debounce_timer = nil

    vim.notify(
      "Failed to start Pywal watcher: " .. tostring(err),
      vim.log.levels.ERROR
    )
    return
  end

  watch_group = vim.api.nvim_create_augroup(
    "PywalWatcher",
    { clear = true }
  )

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = watch_group,
    once = true,
    callback = M.stop_watch,
  })
end

return M
