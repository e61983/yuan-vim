return {
  "numToStr/Comment.nvim",
  lazy = false,
  opts = function()
    return require("config.comment")
  end,
  config = function(_,opts)
    require("Comment").setup(opts)
  end
}
