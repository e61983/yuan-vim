return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		-- snacks.explorer 接管檔案瀏覽，停用 netrw（沿用原 nvim-tree 行為）。
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	opts = {
		input = { enabled = true }, -- 取代 dressing.nvim
		notifier = { enabled = true }, -- 取代 nvim-notify
		explorer = { enabled = true }, -- 取代 nvim-tree
		picker = {
			enabled = true, -- 取代 telescope
			sources = {
				-- 沿用原 nvim-tree 靠右顯示。
				explorer = { layout = { layout = { position = "right" } } },
			},
		},
	},
	keys = {
		-- 檔案瀏覽（原 nvim-tree 的 <F3> / <C-n>）
		{ "<F3>", function() Snacks.explorer() end, desc = "File Explorer" },
		{ "<C-n>", function() Snacks.explorer() end, desc = "File Explorer" },
		-- 搜尋（原 telescope 的 <leader>f*）
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<leader>fg", function() Snacks.picker.grep() end, desc = "Live Grep" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
		{ "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
	},
}
