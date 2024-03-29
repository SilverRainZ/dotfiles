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
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
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

    diagnostics = { theme = "dropdown" },
    lsp_definitions = { theme = "cursor" },
    lsp_implementations = { theme = "cursor" },
    lsp_references = { theme = "cursor" },
    lsp_type_definitions = { theme = "cursor" },
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
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>Telescope file_browser<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope git_files<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
