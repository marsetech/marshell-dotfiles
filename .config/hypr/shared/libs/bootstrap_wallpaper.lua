local wallpaper_utils = {}

local home = os.getenv("HOME")

function wallpaper_utils.get_wallpaper()
  local path = home .. "/.cache/wal/wal"

  local f = io.open(path, "r")
  if not f then return nil end

  local wallpaper = f:read("*a"):gsub("%s+", "")
  f:close()

  return wallpaper
end

return wallpaper_utils
