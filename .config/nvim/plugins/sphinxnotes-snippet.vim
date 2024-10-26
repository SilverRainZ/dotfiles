let snippet_nvim = tempname()
call system('snippet integration --vim --nvim-binding>' . snippet_nvim)
execute 'source ' . snippet_nvim
call delete(snippet_nvim)

function! g:SphinxNotesSnippetUrl(id)
    let url_list = g:SphinxNotesSnippetGet(a:id, 'url')
    for url in url_list
        echo system('la-open ' . shellescape(url))
    endfor
endfunction
