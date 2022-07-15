-- :TSInstall bash c cpp css go gomod html python rst rust yaml
require 'nvim-treesitter.configs'.setup {
    highlight = {
        ensure_installed = { 'go', 'python', 'rst', 'c', 'lua', 'rust' },
        enable = true,
        disable = {},
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
