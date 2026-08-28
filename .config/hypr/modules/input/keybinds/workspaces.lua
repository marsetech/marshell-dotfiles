local input = require("shared.config.modifiers")

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(input.primary_key .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(input.secondary_key .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(input.primary_key .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(input.primary_key .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(input.primary_key .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
