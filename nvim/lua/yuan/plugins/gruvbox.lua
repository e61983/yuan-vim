return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = true,
  opts = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}
