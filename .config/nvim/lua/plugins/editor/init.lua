-- ============================================================================
-- Plugins dependencies
-- ============================================================================
require("plugins.editor.autopairs")
require("plugins.editor.comments")
require("plugins.editor.trailspace")
require("plugins.editor.autotag")
require("plugins.editor.completion")

-- ============================================================================
-- Snacks-related plugins dependencies
-- ============================================================================
return {
  bigfile_handler = require("plugins.editor.bigfile"),
  smooth_scrolling = require("plugins.editor.scrolling"),
}
