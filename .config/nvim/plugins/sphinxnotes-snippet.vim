let snippet_nvim = tempname()
call system('snippet integration --vim --nvim-binding>' . snippet_nvim)
execute 'source ' . snippet_nvim
call delete(snippet_nvim)

function! g:SphinxNotesSnippetUrl(id)
    let url_list = systemlist(join(['snippet', 'get', '--url', a:id], ' '))
    for url in url_list
        echo system('url ' . shellescape(url))
    endfor
endfunction
