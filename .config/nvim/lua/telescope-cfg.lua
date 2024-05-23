local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = actions.which_key,
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-n>"] = actions.close, -- for file_browser
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },

    -- Shorten long path.
    -- https://github.com/nvim-telescope/telescope.nvim/issues/895#issuecomment-1021972829
    path_display = {'smart'},
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    --
    find_files = { theme = "ivy" },
    git_files = { theme = "ivy" },
    live_grep = { theme = "ivy" },

    diagnostics = { theme = "dropdown" },
    lsp_definitions = { theme = "dropdown" },
    lsp_implementations = { theme = "dropdown" },
    lsp_references = { theme = "dropdown" },
    lsp_type_definitions = { theme = "dropdown" },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    --
    file_browser = {
      theme = 'ivy',
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
            -- your custom insert mode mappings
        },
        ["n"] = {
            -- your custom normal mode mappings
        },
      },
    },
  },
}

require("telescope").load_extension "file_browser"

vim.api.nvim_exec([[

" https://stackoverflow.com/a/5800087/4799273
function! StartUp()
    if 0 == argc()
        Telescope file_browser
    end
endfunction

" autocmd VimEnter * call StartUp()

]], false)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local builtin = require('telescope.builtin')
local extensions = require("telescope").extensions
vim.keymap.set('n', '<C-n>', extensions.file_browser.file_browser, {})
vim.keymap.set('n', '<leader>ff', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
