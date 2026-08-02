local palette = require("shared.libs.bootstrap_colors")

---- DECORATIONS --------------------------------------------------
hl.config({
  general = {
    gaps_in          = 2,
    gaps_out         = 4,

    border_size      = 2,

    col              = {
      active_border   = palette.color2,
      inactive_border = palette.background,
    },
    resize_on_border = false,
    allow_tearing    = false,
  },

  decoration = {
    rounding         = 0,
    rounding_power   = 2,

    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = palette.background,
    },
    blur             = {
      enabled           = true,
      size              = 5,
      passes            = 4,
      vibrancy          = 0.1696,
      ignore_opacity    = true,
      new_optimizations = true,
      xray              = true,
    },
  },
})
