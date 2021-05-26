autocmd BufRead *.rst,*.md :Goyo 80

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

    " Ensure :q to quit even when Goyo is active
    " https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
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

    " Ensure :q to quit even when Goyo is active
    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
