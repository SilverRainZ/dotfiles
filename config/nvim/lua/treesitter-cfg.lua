require('tree-sitter-manager').setup({
  ensure_installed = {
    'go', 'python', 'rst', 'c', 'lua', 'rust', 'bash', 'comment',
    'nu', 'scheme', 'markdown',
  },
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
