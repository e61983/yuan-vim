return { 
  "lukas-reineke/indent-blankline.nvim", 
  main = "ibl", 
  opts = function()
    return require("config.indent-blankline")
  end,
  config = function (_,opts)
    require("ibl").setup(opts)
  end
}
