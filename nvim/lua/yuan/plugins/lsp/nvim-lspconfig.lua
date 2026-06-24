return {
	"neovim/nvim-lspconfig",
	ft = "go",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		vim.lsp.config("gopls", {
			cmd = { "gopls", "serve" },
			capabilities = capabilities,
			filetypes = { "go", "gomod", "gotmpl" },
			root_markers = { "go.work", "go.mod", ".git" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
					completeUnimported = true,
					gofumpt = true,
					usePlaceholders = true,
				},
			},
		})
		vim.lsp.enable("gopls")
	end,
}
