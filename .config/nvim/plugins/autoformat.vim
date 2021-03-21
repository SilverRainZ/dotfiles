au BufWrite *.c :Autoformat
au BufWrite *.h :Autoformat

let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
let g:autoformat_verbosemode = 0

function! FindAstylerc()
    let l:astylerc = '.astylerc'
    let l:cur = '%:p:h'
    let l:home = expand('~/' . astylerc)
    let l:root = '/' . astylerc
    let l:found = 0

    while 1
        let f = expand(cur) . '/' . astylerc
        if filereadable(f)
            let found = 1
            break
        endif
        if (f == home) || (f == root)
            break
        endif
        let cur = cur . ':h' " To upper directory
    endwhile

    if !found
        return ''
    else
        return f
    endif
endfunction

let astylerc = FindAstylerc()
if filereadable(astylerc)
    let g:formatdef_my_astyle_c = '"astyle --mode=c --options=' . astylerc . '"'
    let g:formatters_c = ['my_astyle_c']
    let g:formatters_h = ['my_astyle_c']
    let g:formatters_cpp = ['my_astyle_c']
else
    let g:formatters_c = []
    let g:formatters_h = []
    let g:formatters_cpp = []
endif
