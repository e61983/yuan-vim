return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = { "InsertEnter", "LspAttach" },
	fix_pairs = true,
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
			server_opts_overrides = {
				trace = "verbose",
				settings = {
					advanced = {
						listCount = 10, -- #completions for panel
						inlineSuggestCount = 3, -- #completions for getCompletions
					},
				},
			},
		})
		local keymap = vim.keymap
		keymap.set("i", "<CR>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.g.copilot_no_tab_map = true
	end,
}
