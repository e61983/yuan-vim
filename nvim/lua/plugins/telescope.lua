vim.keymap.set("n", "<C-p>", "<cmd> Telescope find_files <CR>")
return {
    "nvim-telescope/telescope.nvim",
    dependencies = { 
      "nvim-treesitter/nvim-treesitter", 
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-lua/plenary.nvim"
    },
    cmd = "Telescope",
    opts = function()
      return require "config.telescope"
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
}
