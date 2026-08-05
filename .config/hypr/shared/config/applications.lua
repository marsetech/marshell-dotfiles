local terminal_provider = "kitty"
local file_manager_provider = "yazi"

return {
  terminal = terminal_provider,
  file_manager = terminal_provider .. file_manager_provider,
  root_file_manager = terminal_provider .. " sudo -E " .. file_manager_provider,

  music = "spotify",
  browser = "brave-origin",
  editor = "zeditor",
  screen_recording = "obs"
}
