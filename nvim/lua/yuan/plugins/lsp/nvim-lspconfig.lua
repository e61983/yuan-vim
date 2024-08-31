return {
	"neovim/nvim-lspconfig",
	ft = "go",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.gopls.setup({
			cmd = { "gopls", "serve" },
			capabilities = capabilities,
			filetypes = { "go", "gomod", "gotmpl" },
			root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
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
	end,
}
