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

" Make backspace work like you would expect
set backspace=indent,eol,start


" Get the 2-space YAML as the default when hit carriage return after the colon
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Change cursor based on vim modes
" Source: https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7" "SI = Insert mode
let &t_SR = "\<Esc>]50;CursorShape=2\x7" "SR = Replace mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" "EI = Normal mode (else)

" Toggle GitGutterOnOff
nmap <C-g> :GitGutterToggle<CR>

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Enable GitGutter by default
let g:gitgutter_enabled = 1

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

" Set identation for makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'LnL7/vim-nix'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'thaerkh/vim-indentguides'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

" Toggle NERDTree
" t: Open the selected file in a new tab
" i: Open the selected file in a horizontal split window
" s: Open the selected file in a vertical split window
" I: Toggle hidden files
" m: Show the NERD Tree menu
" R: Refresh the tree, useful if files change outside of Vim
" ?: Toggle NERD Tree's quick help
nmap <C-n> :NERDTreeToggle<CR>

" Show hidden files in NERDTree
let NERDTreeShowHidden=1

" Commentary shortcuts
" gc - toggle comments
autocmd FileType tf setlocal commentstring=#\ %s

" fzf: search files
nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <Leader>f :Rg<CR>

" fzf: search within files, ignore file names
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


