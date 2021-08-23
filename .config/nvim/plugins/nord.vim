set background=dark
set termguicolors

if exists('g:gnvim')
    let nord_disable_background = v:false
else
    let nord_disable_background = v:true
endif

colorscheme nord
