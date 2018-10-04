" TODO: rust/python language servers
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache"}'],
    \ 'c': ['ccls', '--log-file=/tmp/ccls.log', '--init={"cacheDirectory":"/tmp/ccls-cache"}'],
    \ 'go': ['go-langserver', '-diagnostics', '-gocodecompletion', '-logfile=/tmp/go-langserver.log'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <C-j> :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
