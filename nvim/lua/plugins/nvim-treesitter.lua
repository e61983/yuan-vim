return {
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  lazy = true,
  opts = require("config.nvim-treesitter"),
  config = function (_,opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
