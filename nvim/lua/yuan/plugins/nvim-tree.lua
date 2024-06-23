return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvimtree = require("nvim-tree")
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 30,
        relativenumber = true,
        adaptive_size = false,
        side = "right",
        preserve_window_proportions = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
          },
          glyphs = {
            folder = {
              -- arrow_closed = "", -- arrow when folder is closed
              -- arrow_open = "", -- arrow when folder is open
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    local keymap = vim.keymap
    keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")
  end,
}
