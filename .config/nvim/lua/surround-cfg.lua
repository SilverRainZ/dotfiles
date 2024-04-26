
local config = require('nvim-surround.config')
require('nvim-surround').setup({

  -- reStructuredText input helpers.
  -- TODO: only for *.rst file?
  surrounds = {
    ['``'] = {
      add = { '``', '``' },
    },
    ['**'] = {
      add = { '**', '**' },
    },
    ['role'] = {
      add = function()
        local result = config.get_input('Enter the role name: ')
        if result then
          return { { ':' .. result .. ':`' }, { '`' } }
        else
          return { { '`' }, { '`' } }
        end
      end,
    },
  },
  aliases = {
    -- Alias for reStructuredText input helpers.
    -- Because vim-surrounds only matches one {char}, see ":h nvim-surround.basics".
    ['e'] = '*',
    ['b'] = '**',
    ['c'] = '``',
    ['r'] = 'role',
  },
})
