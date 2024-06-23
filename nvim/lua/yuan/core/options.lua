vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)
opt.ruler = true -- show the line and column number of the cursor position
opt.colorcolumn = "80" -- highlight column 80
opt.textwidth = 80 -- set text width to 80

-- tabs & indentation
opt.tabstop = 4 -- number of spaces that a <Tab> in the file counts for
opt.softtabstop = 4 -- number of spaces that a <Tab> counts for while editing
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.autoindent = true -- copy indent from current line when starting new one
opt.smarttab = true -- use shiftwidth for tabstop
opt.expandtab = true -- expand tab to spaces

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
opt.hls = true -- highlight search results

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
opt.list = true
opt.listchars = {
	tab = "│·",
	extends = "⟩",
	precedes = "⟨",
	trail = "·",
	eol = "↴",
	nbsp = "%",
}

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
