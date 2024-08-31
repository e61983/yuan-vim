return {
	"preservim/tagbar",
	build = function()
		if vim.fn.executable("brew") == 1 then
			vim.fn.system("brew install universal-ctags")
		else
			print("Homebrew not found. Please install universal-ctags manually.")
		end
	end,
	config = function()
		vim.g.tagbar_type_go = {
			ctagstype = "go",
			kinds = {
				"p:package",
				"i:imports:1",
				"c:constants",
				"v:variables",
				"t:types",
				"n:interfaces",
				"w:fields",
				"e:embedded",
				"m:methods",
				"r:constructor",
				"f:functions",
			},
			sro = ".",
			kind2scope = {
				t = "ctype",
				n = "ntype",
			},
			scope2kind = {
				ctype = "t",
				ntype = "n",
			},
			ctagsbin = "gotags",
			ctagsargs = "-sort -silent",
		}
		local winwidth = vim.fn.winwidth(0)
		vim.g.tagbar_position = "topleft vertical"
		vim.g.tagbar_width = math.max(25, winwidth / 5)
		vim.g.tagbar_autofocus = 1
		vim.keymap.set("n", "<F2>", "<cmd> TagbarToggle <CR>")
	end,
}
