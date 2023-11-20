local options = {
  options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
           filetype = "NvimTree",
           text = "File Explorer",
           highlight = "Directory",
           text_align = "left"
        }
      }
    }
}
vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>")

return options
