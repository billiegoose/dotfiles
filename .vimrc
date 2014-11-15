set nu
set nowrap
set scrolloff=3
set wildmenu
set wildmode=list:longest
    set tabstop=2
    set shiftwidth=2
    set expandtab
set smarttab
set softtabstop=2
set autoindent
set nobackup
set nowritebackup
set dir=~/.vimswap//,/var/tmp//,/tmp//
set undofile
set undodir=~/.vimundo/
set cursorline

" Pathogen plugins
execute pathogen#infect()
syntax enable
filetype plugin indent on

" Solarized theme
set background=dark
let g:solarized_bold=0
let g:solarized_underline=0
let g:solarized_italic=0
let g:solarized_termtrans=1
colorscheme solarized
