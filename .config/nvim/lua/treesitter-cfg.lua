-- :TSInstall bash c cpp css go gomod html python rst rust yaml
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {}
    },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
