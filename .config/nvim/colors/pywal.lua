-- colors/pywal.lua

local pywal = require("lib.pywal")
local colors = pywal.colors()

-- ============================================================================
-- Helper
-- ============================================================================

local function set_hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ============================================================================
-- Editor
-- ============================================================================

set_hl("Normal", {
  fg = colors.foreground,
  bg = "NONE",
})

set_hl("NormalNC", {
  fg = colors.foreground,
  bg = "NONE",
})

set_hl("NormalFloat", {
  fg = colors.foreground,
  bg = "NONE",
})

set_hl("FloatBorder", {
  fg = colors.color8,
  bg = colors.color0,
})

set_hl("FloatTitle", {
  fg = colors.color4,
  bg = colors.color0,
  bold = true,
})

set_hl("Cursor", {
  fg = colors.background,
  bg = colors.foreground,
})

set_hl("CursorLine", {
  bg = colors.color0,
})

set_hl("CursorColumn", {
  bg = colors.color0,
})

set_hl("LineNr", {
  fg = colors.color8,
})

set_hl("CursorLineNr", {
  fg = colors.foreground,
  bold = true,
})

set_hl("SignColumn", {
  fg = colors.color8,
  bg = "NONE",
})

set_hl("FoldColumn", {
  fg = colors.color8,
  bg = "NONE",
})

set_hl("Folded", {
  fg = colors.color8,
  bg = colors.color0,
})

set_hl("WinSeparator", {
  fg = colors.color0,
  bg = colors.background,
})

set_hl("VertSplit", {
  fg = colors.color0,
  bg = colors.background,
})

set_hl("Visual", {
  fg = colors.background,
  bg = colors.color4,
})

set_hl("Search", {
  fg = colors.background,
  bg = colors.color3,
})

set_hl("IncSearch", {
  fg = colors.background,
  bg = colors.color5,
})

set_hl("CurSearch", {
  fg = colors.background,
  bg = colors.color6,
})

set_hl("MatchParen", {
  fg = colors.foreground,
  bg = colors.color0,
  bold = true,
})

set_hl("Directory", {
  fg = colors.color4,
})

set_hl("Title", {
  fg = colors.color4,
  bold = true,
})

set_hl("NonText", {
  fg = colors.color8,
})

set_hl("SpecialKey", {
  fg = colors.color8,
})

set_hl("Whitespace", {
  fg = colors.color0,
})

set_hl("Conceal", {
  fg = colors.color8,
})

-- ============================================================================
-- Syntax
-- ============================================================================

set_hl("Comment", {
  fg = colors.color8,
  italic = true,
})

set_hl("String", {
  fg = colors.color2,
})

set_hl("Character", {
  fg = colors.color2,
})

set_hl("Number", {
  fg = colors.color4,
})

set_hl("Boolean", {
  fg = colors.color5,
})

set_hl("Constant", {
  fg = colors.color4,
})

set_hl("Identifier", {
  fg = colors.foreground,
})

set_hl("Function", {
  fg = colors.color6,
})

set_hl("Statement", {
  fg = colors.color5,
})

set_hl("Keyword", {
  fg = colors.color5,
  bold = true,
})

set_hl("Operator", {
  fg = colors.color6,
})

set_hl("Type", {
  fg = colors.color3,
})

set_hl("Structure", {
  fg = colors.color3,
})

set_hl("Special", {
  fg = colors.color6,
})

set_hl("PreProc", {
  fg = colors.color5,
})

set_hl("Todo", {
  fg = colors.background,
  bg = colors.color3,
  bold = true,
})

set_hl("Error", {
  fg = colors.color1,
  bold = true,
})

-- ============================================================================
-- Completion
-- ============================================================================

set_hl("Pmenu", {
  fg = colors.foreground,
  bg = colors.color0,
})

set_hl("PmenuSel", {
  fg = colors.background,
  bg = colors.color4,
  bold = true,
})

set_hl("PmenuSbar", {
  bg = colors.color0,
})

set_hl("PmenuThumb", {
  bg = colors.color8,
})

-- ============================================================================
-- Diagnostics
-- ============================================================================

set_hl("DiagnosticError", {
  fg = colors.color1,
})

set_hl("DiagnosticWarn", {
  fg = colors.color3,
})

set_hl("DiagnosticInfo", {
  fg = colors.color6,
})

set_hl("DiagnosticHint", {
  fg = colors.color2,
})

set_hl("DiagnosticSignError", {
  fg = colors.color1,
})

set_hl("DiagnosticSignWarn", {
  fg = colors.color3,
})

set_hl("DiagnosticSignInfo", {
  fg = colors.color6,
})

set_hl("DiagnosticSignHint", {
  fg = colors.color2,
})

set_hl("DiagnosticVirtualTextError", {
  fg = colors.color1,
})

set_hl("DiagnosticVirtualTextWarn", {
  fg = colors.color3,
})

set_hl("DiagnosticVirtualTextInfo", {
  fg = colors.color6,
})

set_hl("DiagnosticVirtualTextHint", {
  fg = colors.color2,
})

set_hl("DiagnosticUnderlineError", {
  undercurl = true,
  sp = colors.color1,
})

set_hl("DiagnosticUnderlineWarn", {
  undercurl = true,
  sp = colors.color3,
})

set_hl("DiagnosticUnderlineInfo", {
  undercurl = true,
  sp = colors.color6,
})

set_hl("DiagnosticUnderlineHint", {
  undercurl = true,
  sp = colors.color2,
})

-- ============================================================================
-- Treesitter
-- ============================================================================

set_hl("@comment", {
  link = "Comment",
})

set_hl("@string", {
  link = "String",
})

set_hl("@string.escape", {
  fg = colors.color6,
})

set_hl("@function", {
  link = "Function",
})

set_hl("@function.call", {
  link = "Function",
})

set_hl("@function.method", {
  link = "Function",
})

set_hl("@function.method.call", {
  link = "Function",
})

set_hl("@keyword", {
  link = "Keyword",
})

set_hl("@keyword.function", {
  link = "Keyword",
})

set_hl("@keyword.return", {
  link = "Keyword",
})

set_hl("@type", {
  link = "Type",
})

set_hl("@type.builtin", {
  link = "Type",
})

set_hl("@type.definition", {
  link = "Type",
})

set_hl("@constant", {
  link = "Constant",
})

set_hl("@constant.builtin", {
  link = "Constant",
})

set_hl("@number", {
  link = "Number",
})

set_hl("@boolean", {
  link = "Boolean",
})

set_hl("@operator", {
  link = "Operator",
})

set_hl("@variable", {
  link = "Identifier",
})

set_hl("@variable.builtin", {
  fg = colors.color13,
})

set_hl("@property", {
  fg = colors.foreground,
})

set_hl("@variable.parameter", {
  fg = colors.foreground,
})

set_hl("@tag", {
  fg = colors.color4,
})

set_hl("@tag.attribute", {
  fg = colors.color3,
})

set_hl("@tag.delimiter", {
  fg = colors.color8,
})

-- ============================================================================
-- LSP
-- ============================================================================

set_hl("@lsp.type.function", {
  link = "@function",
})

set_hl("@lsp.type.method", {
  link = "@function",
})

set_hl("@lsp.type.type", {
  link = "@type",
})

set_hl("@lsp.type.class", {
  link = "@type",
})

set_hl("@lsp.type.variable", {
  link = "@variable",
})

set_hl("@lsp.type.parameter", {
  link = "@variable.parameter",
})

-- ============================================================================
-- Diff
-- ============================================================================

set_hl("DiffAdd", {
  fg = colors.color2,
  bg = colors.background,
})

set_hl("DiffChange", {
  fg = colors.color3,
  bg = colors.background,
})

set_hl("DiffDelete", {
  fg = colors.color1,
  bg = colors.background,
})

set_hl("DiffText", {
  fg = colors.color4,
  bg = colors.color0,
})

-- ============================================================================
-- Statusline
-- ============================================================================

set_hl("StatusLine", {
  fg = colors.foreground,
  bg = "NONE",
})

set_hl("StatusLineNC", {
  fg = colors.color8,
  bg = "NONE",
})

-- ============================================================================
-- Colorscheme
-- ============================================================================

vim.g.colors_name = "pywal"
vim.opt.background = "dark"
