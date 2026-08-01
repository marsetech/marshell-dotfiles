local M = {}

-- =========================================================
--  Registry (per lookup esterni, es. spawn_or_focus)
-- =========================================================
M.registry = {}

-- =========================================================
--  Helpers
-- =========================================================

---@param list string[]
---@return string
local function regex_from_list(list)
  return "^(" .. table.concat(list, "|") .. ")$"
end

---@param ... table
---@return table
local function merge(...)
  local merged = {}

  for i = 1, select("#", ...) do
    local tbl = select(i, ...)

    if tbl then
      for key, value in pairs(tbl) do
        merged[key] = value
      end
    end
  end

  return merged
end

M.regex_from_list = regex_from_list

-- =========================================================
--  Shared presets
-- =========================================================

M.opacity = {
  system = {
    opacity = "0.90 override 0.80 override"
  }
}

M.behaviour = {
  floating = {
    float = true,
    center = true,
    keep_aspect_ratio = true,
  },
  focused = {
    stay_focused = true,
  },
}

M.size = {
  tiny = {
    size = { "monitor_w * 0.25", "monitor_h * 0.25" },
  },
  small = {
    size = { "monitor_w * 0.5", "monitor_h * 0.5" },
  },
  default = {
    size = { "monitor_w * 0.75", "monitor_h * 0.75" },
  },
  ultrawide = {
    size = { "monitor_w * 0.8", "monitor_h * 0.7" },
  },
}

M.workspace = {
  terminal = {
    workspace = "1",
  },
  web = {
    workspace = "2",
  },
  coding = {
    workspace = "3",
  },
  music = {
    workspace = "4",
  },
  social = {
    workspace = "5",
  },
  screen_recording = {
    workspace = "10",
  },
}

-- =========================================================
--  Window Group Factory
-- =========================================================

---@param opts table
function M.window_group(opts)
  assert(opts.name, "window_group: missing 'name'")
  assert(opts.match, "window_group: missing 'match'")

  local final_match = {}

  for key, value in pairs(opts.match) do
    if type(value) == "table" then
      final_match[key] = regex_from_list(value)
    else
      final_match[key] = value
    end
  end

  -- merge flattens all rule presets directly into the root table
  -- so hl.windowrule receives: { name, tag, match, opacity, float, ... }
  local rule = merge(
    {
      name  = opts.name,
      tag   = opts.tag or ("+" .. opts.name),
      match = final_match,
    },
    table.unpack(opts.rules or {})
  )
  M.registry[opts.name] = final_match

  hl.window_rule(rule)
end

return M
