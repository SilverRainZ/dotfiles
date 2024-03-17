-- Logging.
-- vim.lsp.set_log_level("debug")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
-- 'e': means error.
vim.api.nvim_set_keymap('n', '<leader>e',
'<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>',
opts)
vim.api.nvim_set_keymap('n', '<leader>ne', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>Ne', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- 'q': Open quickfix windows.
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --
  -- Many servers do not implement this method.
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
  -- '<cmd>lua vim.lsp.buf.definition()<CR>',
  '<cmd>Telescope lsp_definitions<CR>',
  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi',
  -- '<cmd>lua vim.lsp.buf.implementation()<CR>',
  '<cmd>Telescope lsp_implementations<CR>',
  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr',
  -- '<cmd>lua vim.lsp.buf.references()<CR>',
  '<cmd>Telescope lsp_references<CR>',
  opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt',
  -- '<cmd>lua vim.lsp.buf.type_definition()<CR>',
  '<cmd>Telescope lsp_type_definitions<CR>',
  opts)
  -- Conflicts with sphinxnotes-snippet.
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
--
-- esbonio: pip install esbonio
-- gopls: go install golang.org/x/tools/gopls@latest
local servers = { 'pyright', 'rust_analyzer', 'gopls', 'esbonio' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
  }
end

require("hover").setup {
  init = function()
    require("hover.providers.lsp")
  end,
  preview_opts = { border = 'single' },
  -- Whether the contents of a currently open hover window should be moved
  -- to a :h preview-window when pressing the hover keymap.
  preview_window = false,
  title = true,
}
vim.keymap.set('n', 'K', require("hover").hover, {desc = "hover.nvim"})
