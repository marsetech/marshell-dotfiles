local home = os.getenv("HOME")

local colors_dir = ".cache/wal/"
local file_name = "colors-hyprland"

package.path = home .. "/" .. colors_dir .. "?.lua;" .. package.path

return require(file_name)
