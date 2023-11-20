return {
  'nvim-lualine/lualine.nvim',
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = require("config.lualine"),
  config = function(_,opts)
    require("lualine").setup(opts)
  end
}
