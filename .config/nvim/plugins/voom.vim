let g:voom_tree_placement = "right"


let g:isVoomToggled = 0

function! g:ToggleVoom()
    if g:isVoomToggled
        :Voomquit
        let g:isVoomToggled = 0
        return
    endif

    let g:isVoomToggled = 1
    if &filetype == 'rst' || &filetype == 'rest'
        :Voom rest
        :set nonumber
    elseif &filetype == 'md' || &filetype == 'markdown'
        :Voom markdown
    elseif &filetype == 'html' || &filetype == 'htm'
        :Voom html
    endif
endfunction

map <C-o> :call g:ToggleVoom()<CR>
