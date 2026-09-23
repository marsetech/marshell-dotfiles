local terminal_provider = "~/.config/hypr/scripts/system/terminal-handler.service.sh"
local file_manager_provider = "~/.config/hypr/scripts/desktop/file-manager-session-manager.sh"

return {
  terminal = terminal_provider,
  file_manager = file_manager_provider .. " --user",
  root_file_manager = file_manager_provider .. " --system",

  music = "spotify",
  browser = "~/.config/hypr/scripts/system/browser-handler.service.sh",
  editor = "~/.config/hypr/scripts/system/editor-handler.service.sh",
  screen_recording = "obs"
}
