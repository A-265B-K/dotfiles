local o = vim.opt
local g = vim.g

o.shiftwidth = 8
o.tabstop = 8
o.number = true
o.relativenumber = true
o.textwidth = 80
o.showcmd = true
o.showmatch = true
o.smartindent = true
o.autoindent = true
o.list = true
o.listchars:append({ tab = "ᘳ-ᘰ", space = "ᘯ", eol = "ᘱ" })
o.colorcolumn = "+1"
o.wrap = false
o.swapfile = false
o.mouse = {}
o.cursorline = true
o.cursorlineopt = "number"
o.incsearch = true
o.signcolumn = "yes"
o.foldenable = true
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.lsp.foldexpr()"
o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldcolumn = "0"
g.c_syntax_for_h = true
g.mapleader = " "
g.maplocalleader = "\\"

o.clipboard = "unnamedplus" -- paste-buffer == system clipboard

vim.filetype.add({
	extension = {
		tpp = "cpp",
		nasm = "asm",
		mac = "asm",
		h = "c",
		rpy = "python",
	},
})
