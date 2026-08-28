local input = require("shared.config.modifiers")

---- Focus window movement ------------------------------------------------
hl.bind(input.primary_key .. " + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind(input.primary_key .. " + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind(input.primary_key .. " + UP", hl.dsp.focus({ direction = "up" }))
hl.bind(input.primary_key .. " + DOWN", hl.dsp.focus({ direction = "down" }))

---- Resizing windows -----------------------------------------
local resize_value = 50

hl.bind(input.secondary_key .. " + LEFT",
  hl.dsp.window.resize({
    x = -resize_value,
    y = 0,
    relative = true,
  }),
  { repeating = true }
)
hl.bind(input.secondary_key .. " + RIGHT",
  hl.dsp.window.resize({
    x = resize_value,
    y = 0,
    relative = true,
  }),
  { repeating = true }
)
hl.bind(input.secondary_key .. " + UP",
  hl.dsp.window.resize({
    x = 0,
    y = -resize_value,
    relative = true,
  }),
  { repeating = true }
)
hl.bind(input.secondary_key .. " + DOWN",
  hl.dsp.window.resize({
    x = 0,
    y = resize_value,
    relative = true,
  }),
  { repeating = true }
)

---- Mouse bindings actions --------------------------------------------
hl.bind(input.primary_key .. "+ mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(input.primary_key .. "+ mouse:273", hl.dsp.window.resize(), { mouse = true })
