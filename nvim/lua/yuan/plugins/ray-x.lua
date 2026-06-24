return {
	"ray-x/go.nvim",
	lazy = true,
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()',
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"saghen/blink.cmp",
	},
	config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
		require("go").setup({
			icons = { breakpoint = "B", currentpos = "→" },
            lsp_cfg = {
              capabilities = capabilities,
            },
            lsp_inlay_hints = {
                -- only_current_line = true,
                -- only_current_line_autocmd = "CursorHold",
                show_variable_name = true,
            },
		})

		vim.keymap.set("n", "<leader>b", "<cmd>GoDebug -b<CR>")
		vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<CR>")
		vim.keymap.set("n", "<leader>gfss", "<cmd>GoFillSwitch<CR>")
		vim.keymap.set("n", "<leader>gjt", "<cmd>GoAddTag<CR>")
		vim.keymap.set("n", "<leader>gat", "<cmd>GoAddTest<CR>")
		vim.keymap.set("n", "<F5>", "<cmd>GoDebug<CR>", { noremap = true, silent = true })


		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").goimport()
			end,
			group = format_sync_grp,
		})
	end,
}
