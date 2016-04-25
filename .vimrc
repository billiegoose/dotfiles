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
set hlsearch

" Use CTRL-S for fast saving, also in Insert and Visual mode (taken from mswin.vim)
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Clear search highlighting by hitting Esc
" nnoremap <Esc> :noh<CR><Esc>
