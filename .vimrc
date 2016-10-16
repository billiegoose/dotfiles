set number        " show line numbers
set nowrap        " only fools wrap lines
set scrolloff=3   " scroll offset starts scrolling when cursor is 3 lines from edge
set cursorline    " highlight the current line the cursor is on
set hlsearch      " highlight search matches in document

set expandtab     " use spaces instead of <HT> characters
set tabstop=2     " how wide to display <HT> characters
set softtabstop=2 " how many spaces to insert when hitting Tab key
set shiftwidth=2  " how many spaces to shift lines when using the >> and << commands 
set smarttab      " makes backspace delete 'shiftwidth' spaces
set autoindent    " match indentation of previous line when you create a new line

set undofile      " Save the undo history for files and remember it between sessions.
set undodir=~/.vimundo/ " Put those undo history files in ~/.vimundo

" By default Vim likes to place its swap buffer files in the same directory as the
" original file. This can upset build chain tools that watch directories for changes
" and generally is annoying. This forces all swap files to be saved in ~/.vimswap
" or if that is not available in /var/tmp or /tmp
set dir=~/.vimswap//,/var/tmp//,/tmp//

set nobackup      " I'll manage my own backups, thank you
set nowritebackup " No seriously, I already have a backup it's called git

" Map CTRL-S to save, also in Insert and Visual mode (taken from mswin.vim)
noremap  <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" Tab completion for vim commands from http://stackoverflow.com/a/13043196/2168416
set wildmenu
set wildmode=longest:full,full 
" That means that on first <Tab> it will complete to the longest common string and
" will invoke wildmenu (an horizontal and unobstructive little menu). On next <Tab>
" it will complete the first altenative and the will start to cycle through the rest.
" You can go back and forth with <Tab> and <S-Tab> respectively.
