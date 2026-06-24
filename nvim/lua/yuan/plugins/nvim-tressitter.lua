return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"json",
			"javascript",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"vimdoc",
			"c",
			"go",
		})

		-- main 分支移除了 module 系統，highlight 改由 Neovim 提供。
		-- 對每個有 parser 的 buffer 啟用 highlight 與 treesitter 折疊。
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				if not pcall(vim.treesitter.start) then
					return
				end
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0][0].foldlevel = 99
			end,
		})
	end,
}
