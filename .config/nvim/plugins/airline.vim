if exists("g:gui_oni")
    let g:loaded_airline=1
    set laststatus=0
endif

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

if (g:colors_name=="solarized")
    let g:airline_solarized_bg='dark'
    let g:solarized_termcolors=256
    let g:airline_theme='solarized'
elseif (g:colors_name=="nord")
    let g:airline_theme='nord'
endif
