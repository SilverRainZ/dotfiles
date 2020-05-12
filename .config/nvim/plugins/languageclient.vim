" TODO: rust language server

" pacman -S archlinuxcn/ccls-git
" Would be better to use gopls of master@go-tools.
" pacman -S python-language-server python-pyflakes yapf
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache", "index": {"threads": 1}}'],
    \ 'c': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache", "index": {"threads": 1}}'],
    \ 'go': ['/home/la/go/bin/gopls'],
    \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <C-j> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

au FileType cpp,go set formatexpr=LanguageClient#textDocument_rangeFormatting()
autocmd BufWritePre *.cpp,*.go :call LanguageClient#textDocument_formatting_sync()

" For debug
" let g:LanguageClient_loggingFile=expand('~/.local/share/nvim/LanguageClient.log')
" let g:LanguageClient_loggingLevel='DEBUG'
