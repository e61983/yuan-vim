return {
	"mfussenegger/nvim-dap",
	ft = { "go" },
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		require("dapui").setup()
		require("dap-go").setup()

		require("nvim-dap-virtual-text").setup({
			-- display_callback = function(variable)
			-- 	local name = string.lower(variable.name)
			-- 	local value = string.lower(variable.value)
			-- 	if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
			-- 		return "*****"
			-- 	end
			--
			-- 	if #variable.value > 15 then
			-- 		return " " .. string.sub(variable.value, 1, 15) .. "... "
			-- 	end
			--
			-- 	return " " .. variable.value
			-- end,
		})

		dap.adapters.go = {
			type = "server",
			port = "${port}",
			executable = {
				command = "dlv",
				args = { "dap", "-l", "127.0.0.1:${port}" },
			},
		}

		-- 原 go.nvim 的 GoDebug / GoDebug -b，改用 dap 原生操作。
		vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP continue / start" })
		vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "DAP toggle breakpoint" })
	end,
}
