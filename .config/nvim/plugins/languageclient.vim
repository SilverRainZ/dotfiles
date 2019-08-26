" TODO: rust language server

" pacman -S archlinuxcn/ccls-git
" pacman -S archlinuxcn/go-langserver-git
" pacman -S python-language-server python-pyflakes yapf
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache", "index": {"threads": 1}}'],
    \ 'c': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache", "index": {"threads": 1}}'],
    \ 'go': ['go-langserver', '-diagnostics', '-gocodecompletion', '-logfile=/tmp/go-langserver.log'],
    \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <C-j> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
