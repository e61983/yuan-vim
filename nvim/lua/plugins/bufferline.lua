return {
  "akinsho/bufferline.nvim", 
  version = "*", 
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = function()
    return require("config.bufferline")
  end,
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
}

