-- lua/plugins/development/init.lua

-- ============================================================================
-- Plugins dependencies
-- ============================================================================
require("plugins.development.treesitter")
require("plugins.development.todo-comments")

-- ============================================================================
-- Snacks-related plugins dependencies
-- ============================================================================
return {
  git = require("plugins.development.git"),
}
