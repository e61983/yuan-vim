return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = { "InsertEnter", "LspAttach" },
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
			-- fix_pairs = true,
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
		vim.g.copilot_no_tab_map = true
	end,
}
