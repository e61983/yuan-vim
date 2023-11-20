return {
  "williamboman/mason-lspconfig",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
  },
  config = function()
    require("config.lsp")
  end,
}
