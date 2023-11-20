require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

local lspconfig = require('lspconfig')
local util = require "lspconfig/util"
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "clangd",
    "dockerls",
  },
  automatic_installation = true,
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end,
    ['gopls'] = function()
      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = {"gopls"},
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
          },
        }
      })
    end
  }
})
