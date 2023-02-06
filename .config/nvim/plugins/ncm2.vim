" Enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" Disable for Telescope prompt
" https://github.com/nvim-telescope/telescope.nvim/issues/161
autocmd FileType TelescopePrompt call ncm2#disable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" Suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <C-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu.
inoremap <expr> <CR> (pumvisible() ? "\<C-y>" : "\<CR>")

" Use <C-j/k> to select the popup menu:
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
