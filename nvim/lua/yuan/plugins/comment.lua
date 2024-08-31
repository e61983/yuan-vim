return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()

		local keymap = vim.keymap
		keymap.set("n", "<leader>c<space>", function()
			require("Comment.api").toggle.linewise.current()
		end)
		keymap.set(
			"v",
			"<leader>c<space>",
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
		)
	end,
}
