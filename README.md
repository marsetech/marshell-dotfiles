<div align="center">
  <img width=100% alt="Repository Banner" src="assets/banner.webp"/>
</div>

<div align="center" style="margin-top: -5px;">
  <img width=50% alt="Repository Title Banner" src="assets/header.webp"/>
</div>

<div align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=600&size=16&pause=3000&color=67716F&center=true&vCenter=true&width=375&height=35&lines=Crafting+a+system+that+feels+like+home." alt="Typing SVG" />
</div>

<div align="center">
  <div style="display: flex; flex-wrap: nowrap; justify-content: center; margin-top: -10px;">
    <img src="assets/logo/endeavouros.png" alt="EndeavourOS" style="width: 5%; height: 3%; margin: 50px;"/>
    <img src="assets/logo/cachyos.png" alt="CachyOS" style="width: 6%; height: 3%; margin: 50px;"/>
    <img src="assets/logo/archlinux.png" alt="Arch Linux" style="width: 5%; height: 3%; margin: 50px;"/>
    <img src="assets/logo/garuda.png" alt="Garuda" style="width: 6%; height: 3%; margin: 50px;"/>
    <img src="assets/logo/nixos.png" alt="NixOS" style="width: 6%; height: 3%; margin: 50px;"/>
  </div>
</div>

<div>
  <h2>
    <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=700&size=24&letterSpacing=0.2em&pause=1000&color=317A75&width=435&height=40&lines=OVERVIEW" alt="Typing SVG" style="margin-bottom: -10px;" />
  </h2>
  <div align="center">
    <img src="assets/previews/desktop-overview.png" alt="Hyprland Preview" style="width: 100%"/>
  </div>
</div>

<details>
  <summary><strong>More previews</strong></summary>
  <br>
  <div>
    <img src="assets/previews/desktop-coding.png" alt="Coding Workspace" style="width: 100%; margin-bottom: 15px"/>
    <img src="assets/previews/desktop-music.png" alt="Music Workspace" style="width: 100%; margin-bottom: 15px"/>
    <img src="assets/previews/desktop-socials.png" alt="Socials Workspace" style="width: 100%; margin-bottom: 15px"/>
    <img src="assets/previews/desktop-windows.webp" alt="Hyprland Configuration" style="width: 100%"/>
  </div>
</details>

<h2>
  <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=700&size=24&letterSpacing=0.2em&pause=1000&color=317A75&width=435&height=40&lines=FEATURES" alt="Typing SVG" style="margin-bottom: -10px;" />
</h2>

| Component     | Role                                                                  |
| ------------- | --------------------------------------------------------------------- |
| **Hyprland**  | Wayland compositor — configured in Lua, driven through `hyprctl eval` |
| **Waybar**    | Status bar                                                            |
| **Kitty**     | Terminal emulator                                                     |
| **Rofi**      | Application/utility launcher, TOML-driven menu definitions            |
| **yazi**      | Terminal file manager, with custom session management under Kitty     |
| **swaync**    | Notification daemon                                                   |
| **SDDM**      | Display manager                                                       |
| **starship**  | Fish shell prompt                                                     |
| **pywal**     | System-wide color scheme generation and templating                    |
| **Spicetify** | Spotify theming, integrated with the pywal pipeline                   |
| **lazygit**   | Git TUI                                                               |
| **Zed**       | Primary code editor, themed to match the system palette               |

<h2>
  <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=700&size=24&letterSpacing=0.2em&pause=1000&color=317A75&width=435&height=40&lines=THEMING" alt="Typing SVG" style="margin-bottom: -10px;" />
</h2>

The dotfiles use a centralized theming workflow built around Pywal and wallpaper selection. Application colors are derived from the current wallpaper and propagated through dedicated templates, keeping the visual configuration consistent across Hyprland, Waybar, Rofi, Zed, Cava, Zathura, Discord, Spotify, and other supported applications.

A theme can be regenerated directly from a wallpaper with `wal`, or applied through the custom Rofi wallpaper switcher located in `config/rofi/modules`. The wallpaper switcher handles wallpaper selection and triggers the same theming pipeline, making it the preferred entry point for day-to-day theme changes.

Static application themes are also available where supported, providing a fallback for applications or configurations that do not use Pywal-generated colors. This keeps dynamic wallpaper-based theming separate from application-specific fallback configurations while preserving a consistent dotfiles structure.

<h2>
  <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=700&size=24&letterSpacing=0.2em&pause=1000&color=317A75&width=435&height=40&lines=CREDITS" alt="Typing SVG" style="margin-bottom: -10px;" />
</h2>

This project incorporates ideas inspired by the following open-source projects:

- **Pixie SDDM Theme** — https://github.com/xCaptaiN09/pixie-sddm
- **End-4 dots** — https://github.com/end-4/dots-hyprland
- **HyDE** — https://github.com/HyDE-Project/HyDE

<h2>
  <img src="https://readme-typing-svg.herokuapp.com?font=Roboto+Mono&weight=700&size=24&letterSpacing=0.2em&pause=1000&color=317A75&width=435&height=40&lines=LICENSE" alt="Typing SVG" style="margin-bottom: -10px;" />
</h2>

This project is licensed under the MIT License. For full details, see the [LICENSE](LICENSE) file.
