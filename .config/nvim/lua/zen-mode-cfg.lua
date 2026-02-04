function toggle()
  require("zen-mode").toggle({
    window = {
      width = 100
    }
  })
end

-- vim.keymap.set("n", "<C-g>", toggle, {})

-- FIXME: doesn't work
vim.api.nvim_create_autocmd({'VimEnter'},
{
  pattern = { '*.md', '*.rst', },
  callback = toggle,
})
