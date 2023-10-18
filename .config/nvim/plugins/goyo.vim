" autocmd BufRead *.rst,*.md :Goyo 80
" autocmd BufLeave *.rst,*.md :Goyo!

map <C-g> :Goyo<CR>

let g:goyo_width = 120

function! s:goyo_enter()
    " Smart Wrap
    " https://stackoverflow.com/questions/1204149/smart-wrap-in-vim
    set breakindent

    " GUI improvement
    " https://github.com/junegunn/goyo.vim/wiki/Customization#callbacks-for-gvim
    if has('gui_running')
        set fullscreen
        set background=light
        set linespace=7
    elseif exists('$TMUX')
        silent !tmux set status off
    endif
endfunction

function! s:goyo_leave()
    " Smart Wrap
    set nobreakindent

    " GUI improvement
    if has('gui_running')
        set nofullscreen
        set background=dark
        set linespace=0
    elseif exists('$TMUX')
        silent !tmux set status on
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
