---- Rofi ---------------------------------------
hl.layer_rule({
  match = {
    namespace = "rofi"
  },
  animation = "popin 85%",
})

---- Swaync -------------------------------------
hl.layer_rule({
  match = {
    namespace = "swaync-control-center"
  },
  animation = "slide right",
})
hl.layer_rule({
  match = {
    namespace = "swaync-notification-window"
  },
  animation = "slide right",
})

---- Hyprshot ---------------------------------------
hl.layer_rule({
  match = {
    namespace = "selection"
  },
  animation = "off",
})
