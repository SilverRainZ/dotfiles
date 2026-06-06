let picker_nvim = tempname()
call system('sphinxnotes-picker integration --vim --nvim-binding>' . picker_nvim)
execute 'source ' . picker_nvim
call delete(picker_nvim)

function! g:SphinxNotesPickerUrl(id)
    let url_list = g:SphinxNotesPickerGet(a:id, 'url')
    for url in url_list
        echo system('la-open ' . shellescape(url))
    endfor
endfunction
