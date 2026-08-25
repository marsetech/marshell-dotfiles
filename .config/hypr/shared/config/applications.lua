local terminal_provider = "kitty"
local file_manager_provider = "~/.config/hypr/scripts/desktop/file-manager-session-manager.sh"

return {
  terminal = terminal_provider,
  file_manager = file_manager_provider .. " --user",
  root_file_manager = file_manager_provider .. " --system",

  music = "spotify",
  browser = "brave-origin",
  editor = "zeditor",
  screen_recording = "obs"
}
