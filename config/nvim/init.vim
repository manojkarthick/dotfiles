filetype plugin indent on
syntax on

set number
set softtabstop=4
set showcmd
set incsearch
set hlsearch
set ic
set noshowcmd
set noruler

" Use space as the leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

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

" Set identation for makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Write/Quit on the capitalized variants as well
" Source: https://coderwall.com/p/nckasg/map-w-to-w-in-vim
command WQ wq
command Wq wq
command W w
command Q q

" Use ruby for syntax highlighting vagrantfiles
augroup vagrant
	au!
	au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END


"------------------------------------------------------------------------------"
"                                    Plugins                                   "
"------------------------------------------------------------------------------"

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'LnL7/vim-nix'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'thaerkh/vim-indentguides'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/vim-easy-align'
Plug 'cespare/vim-toml'
Plug 'cometsong/CommentFrame.vim'
Plug 'Yggdroot/indentLine'
Plug 'nvim-lua/plenary.nvim'
Plug 'famiu/nvim-reload'
Plug 'mhinz/vim-startify'

call plug#end()

"------------------------------------------------------------------------------"
"                                   NERDTree                                   "
"------------------------------------------------------------------------------"
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

"------------------------------------------------------------------------------"
"                                    Signify                                   "
"------------------------------------------------------------------------------"
" default updatetime 4000ms is not good for async update
set updatetime=500
"------------------------------------------------------------------------------"
"                                Vim commentary                                "
"------------------------------------------------------------------------------"
" gc - toggle comments
autocmd FileType tf setlocal commentstring=#\ %s

"------------------------------------------------------------------------------"
"                                 fzf + ripgrep                                "
"------------------------------------------------------------------------------"
" fzf: search files
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

" fzf: search within files, ignore file names
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/*' ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"------------------------------------------------------------------------------"
"                                  Jellybeans                                  "
"------------------------------------------------------------------------------"
" set background to black
let g:jellybeans_overrides = {
			\    'background': { 'guibg': '000000' },
			\}

" Enable italics
let g:jellybeans_use_term_italics = 1

" Set colorscheme to jellybeans
colorscheme jellybeans

"------------------------------------------------------------------------------"
"                                   Lightline                                  "
"------------------------------------------------------------------------------"
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'background': 'dark'
      \ }


"------------------------------------------------------------------------------"
"                                  Easy Align                                  "
"------------------------------------------------------------------------------"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"------------------------------------------------------------------------------"
"                                Comment frames                                "
"------------------------------------------------------------------------------"
let g:CommentFrame_SkipDefaultMappings = 1

