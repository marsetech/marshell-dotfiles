hl.config({
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  }
})

-- ════ Compositor ════════════════════════════════════════════════
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- ════ Nvidia ════════════════════════════════════════════════
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "GBM_BACKEND")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- ════ Cursor ════════════════════════════════════════════════
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
