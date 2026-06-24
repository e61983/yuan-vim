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

		-- 存檔時整理 import 並格式化（取代原 go.nvim 的 goimport，gofumpt 已在 gopls settings 啟用）。
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
			callback = function()
				local params = vim.lsp.util.make_range_params(0, "utf-8")
				params.context = { only = { "source.organizeImports" } }
				local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
				for _, res in pairs(result or {}) do
					for _, action in pairs(res.result or {}) do
						if action.edit then
							vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
						end
					end
				end
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}
