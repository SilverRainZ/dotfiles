if exists("g:gui_oni")
    let g:loaded_airline=1
    set laststatus=0
endif

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
" https://github.com/vim-airline/vim-airline/issues/1043
let g:airline#extensions#tabline#show_splits=0
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#show_tab_type=0

let g:airline_theme='nord_minimal'
