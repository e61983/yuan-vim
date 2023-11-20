return {
  "lewis6991/gitsigns.nvim",
  opts = require("config.gitsigns"),
  config = function(_,opts)
    require("gitsigns").setup(opts)
  end
}
