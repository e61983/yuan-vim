return {
	"neovim/nvim-lspconfig",
	ft = "go",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
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
