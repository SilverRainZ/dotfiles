vim.g.opencode_opts = {
  -- Your configuration, if any — see `lua/opencode/config.lua`, or 'goto definition' on the type or field.
}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- Recommended/example keymaps.
vim.keymap.set({ 'n', 't' }, '<leader>oo', function() require('opencode').toggle() end,                          { desc = 'Toggle opencode' })
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode…' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function() require('opencode').select() end,                          { desc = 'Execute opencode action…' })

vim.keymap.set({ 'n', 'x' }, '<leader>oy',  function() return require('opencode').operator('@this ') end,        { desc = 'Add range to opencode', expr = true })

vim.keymap.set('n', '<S-C-u>', function() require('opencode').command('session.half.page.up') end,   { desc = 'Scroll opencode up' })
vim.keymap.set('n', '<S-C-d>', function() require('opencode').command('session.half.page.down') end, { desc = 'Scroll opencode down' })

-- You may want these if you stick with the opinionated '<C-a>' and '<C-x>' above — otherwise consider '<leader>o…'.
vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
