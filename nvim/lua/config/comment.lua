vim.keymap.set("n", "<leader>c<space>",
  function()
    require("Comment.api").toggle.linewise.current()
  end
)
vim.keymap.set("v", "<leader>c<space>",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
)
return {}
