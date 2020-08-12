filetype plugin indent on
syntax on

set number
set tabstop=4
set softtabstop=4
set showcmd
set cursorline
set incsearch
set hlsearch
set ic

" Reduce delay in cursor redraw when exiting insert mode
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Change cursor based on vim modes
" Source: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7" "SI = Insert mode
let &t_SR = "\<Esc>]50;CursorShape=2\x7" "SR = Replace mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" "EI = Normal mode (else)

" Reset cursor on startup
" t_EI gets executed only when exiting replace/insert mode into normal mode
" On startup enter and immediately exit insert mode to redraw the cursor
" Source: https://vi.stackexchange.com/questions/19748/vimenter-autocmd-to-change-cursor-shape-sometimes-outputs-escape-sequences
augroup ResetCursorShape
au!
autocmd VimEnter * :normal :startinsert :stopinsert 
augroup END

" Reset to underscore cursor on exiting vim
" NOTE: make sure this matches with the iTerm2 cursor setting you are using
autocmd VimLeave * let &t_me="\<Esc>]50;CursorShape=2\x7"

" Change color of line numbers to grey
highlight LineNr ctermfg=grey

