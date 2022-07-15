require('goto-preview').setup {
    -- A function taking two arguments, a buffer and a window to be ran as a hook.
    post_open_hook = function(bufnr, _)
        -- Press <Enter> to close the floating window.
        -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':q<CR>', {noremap = true})
    end
}

local function fn(method)
    return string.format("<cmd>lua require('goto-preview').%s()<CR>", method)
end

-- Mappings.
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>gd', fn('goto_preview_definition'), opts)
-- Only set if you have telescope installed
-- vim.api.nvim_set_keymap('n', 'gr', 'goto_preview_references', opts)
