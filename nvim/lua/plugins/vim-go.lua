return {
  'fatih/vim-go',
  run = ':GoUpdateBinaries',
  ft = 'go',
  config = function ()
    vim.g.go_highlight_types = true
    vim.g.go_highlight_fields = true
    vim.g.go_highlight_functions = true
    vim.g.go_highlight_function_calls = true
    vim.g.go_highlight_operators = true
    vim.g.go_highlight_extra_types = true
    vim.g.go_highlight_build_constraints = true
  end
}
