" :TSInstall bash c cpp css go gomod html python rst rust yaml

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {}
  },
}
EOF
