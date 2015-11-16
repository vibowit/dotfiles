set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" TPope plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
" Plugin "tpope/vim-sensible.git"

Plugin 'airblade/vim-gitgutter'
Plugin 'sjl/gundo.vim.git'

Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'Lokaltog/vim-easymotion'

Plugin 'bling/vim-airline'

Plugin 'andrewle/vim-autoclose'

" Color schemes
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-distinguished'

" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'rking/ag.vim'

" Code completion
" Bundle 'ervandew/supertab'
" Bundle "valloric/YouCompleteMe"
" Bundle "sirver/UltiSnips"
" Bundle "garbas/vim-snipmate"
" Bundle "honza/vim-snippets"

Plugin 'christoomey/vim-tmux-navigator'

Plugin 'mattn/emmet-vim'

" markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'itspriddle/vim-marked'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/seoul256.vim'

call vundle#end()            " required
filetype plugin indent on    " required

set backspace=indent,eol,start
set cursorline cursorcolumn
" let &colorcolumn=join(range(81,999),",")
let &colorcolumn=81
set expandtab
set modelines=2
set shiftwidth=3
if exists('$TMUX')
  set clipboard=
else
   set clipboard=unnamed
endif
set synmaxcol=128
" set ttyscroll=10
set encoding=utf-8
set tabstop=2
set nowrap
set number
set relativenumber
set expandtab
set incsearch
set hlsearch
set wildmenu
set ignorecase
set smartcase
set laststatus=2
set hidden               " can leave buffer without saving
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
if executable('ag')
   set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
   set grepformat=%f:%l:%c:%m
endif
" Backup
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" ----------------------------------------------------------------------
"  Leader Mappings
" ----------------------------------------------------------------------
let mapleader = "\<space>"
let localleader = "\\"

" R/W
nnoremap <leader>q :q<cr>
nnoremap <leader>x :x<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>e :e<cr>

" Misc
nnoremap <leader>tt :split .todo<cr>
nnoremap <leader>S $zf%
nnoremap <leader>mr :let @a=@"<cr>
nnoremap <leader><space> :nohlsearch<cr>

" Meta
nnoremap <leader>me :edit ~/Projects/dotfiles/vimrc<cr>
nnoremap <leader>mr :source $MYVIMRC<cr>
nnoremap <leader>mx "xy@x<cr>

" Toggle things
nnoremap <leader>tn :NERDTreeToggle<CR>
nnoremap <leader>tl :set relativenumber!<cr>

" Quick ESC
" inoremap jj <esc>
inoremap jk <esc>
inoremap kj <esc>

" better newline
inoremap <C-g><Enter> <esc>o

" Jump to the next row on long lines
noremap <Down> gj
noremap <Up>   gk
" nnoremap j gj
" nnoremap k gk
"
" Highlilght last inserted text
nnoremap gV `[v`]

" Turn off search highlight

" shortcuts for windows
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s
" nnoremap <leader>vsa :vert sba<cr>
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" Format the entire file
nnoremap <leader>fef ggVG=

" CtrlP
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_height=40
let g:ctrlp_show_hidden=0
let g:ctrlp_follow_symlinks=1
let g:ctrlp_max_files=600
let g:ctrlp_max_depth = 5
let g:ctrlp_custom_ignore = {
         \ 'dir': '\v[\/]\.(git|hg|svn|idea|cache)$',
         \ 'file': '\v\.DS_Store$'
         \ }
if executable('ag')
   let g:ctrlp_user_command='ag %s -i --nocolor --nogroup --hidden -g ""'
endif
nmap \ [ctrlp]
nnoremap [ctrlp] <nop>
nnoremap [ctrlp]t :CtrlPBufTag<cr>
nnoremap [ctrlp]T :CtrlPTag<cr>
nnoremap [ctrlp]l :CtrlPLine<cr>
" nnoremap [ctrlp]o :CtrlPFunky<cr>
nnoremap [ctrlp]b :CtrlPBuffer<cr>

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=0
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=0
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.git','\.hg']
nnoremap <F3> :NERDTreeFind<CR>

" Gundo
noremap <leader>u :GundoToggle<cr>

" Airline
let g:airline_powerline_fonts=1

" Django improvements
au BufNewFile,BufRead *.html setlocal filetype=htmldjango
au BufNewFile,BufRead urls.py setlocal nowrap

" markdown improvements
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

map <F4> :Goyo<cr>

" toggle paste
map <F6> :set invpaste<CR>:set paste?<CR>

" remap arrow keys
nnoremap <left> :bprev<cr>
nnoremap <right> :bnext<cr>


syntax on
let g:seoul256_background = 235
colorsche seoul256
set background=dark

" add mouse to terminal
set ttyfast
set mouse=a
set mousehide

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  " Hack to get C-h working in neovim
  nmap <BS> <C-W>h
  tnoremap <Esc> <C-\><C-n>
endif

