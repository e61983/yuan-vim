return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- optionally enable 24-bit colour
		vim.opt.termguicolors = true
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = {
					min = 20,
				},
				relativenumber = true,
				side = "right",
			},
			renderer = {
				group_empty = true,
				icons = {
					show = {
						git = true,
						file = true,
						folder = true,
						folder_arrow = true,
					},
					glyphs = {
						folder = {
							arrow_closed = "⏵",
							arrow_open = "⏷",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			filters = {
				dotfiles = false,
				custom = { ".DS_Store", ".git$" },
			},
		})
		vim.keymap.set("n", "<F3>", "<cmd> NvimTreeToggle <CR>")
		vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
	end,
}
