set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

"My Bundles
Bundle 'andrewle/vim-autoclose'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle "tpope/vim-sensible.git"
Bundle "airblade/vim-gitgutter"
Bundle "sjl/gundo.vim.git"

Bundle "bling/vim-airline"
Bundle "scrooloose/nerdtree"
Bundle "Lokaltog/vim-easymotion"

" Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'

" Color schemes
Bundle 'altercation/vim-colors-solarized'
Bundle "tomasr/molokai"
Bundle "Lokaltog/vim-distinguished"

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
" Bundle "garbas/vim-snipmate"
Bundle "sirver/UltiSnips"
Bundle "rking/ag.vim"

  " Optional:
Bundle "honza/vim-snippets"

filetype plugin indent on

let mapleader=","

set cursorline
set expandtab
set modelines=0
set shiftwidth=3
set clipboard=unnamed
set synmaxcol=128
set ttyscroll=10
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
set hidden " can leave buffer without saving

" Backup
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Quick ESC
imap jj <ESC>
imap jk <ESC>

" Jump to the next row on long lines
map <Down> gj
map <Up>   gk
nnoremap j gj
nnoremap k gk

" Highlilght last inserted text
nnoremap gV `[v`]

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<cr>

" Jump to next window
map <leader>w <C-w>w

" Format the entire file
nmap <leader>fef ggVG=

" CtrlP
nnoremap <silent><leader>t :CtrlP<cr>
nnoremap <silent><leader>b :CtrlPBuffer<cr>
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 600
let g:ctrlp_max_depth = 5

" NERDTree
map <leader>n :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen = 0

" Gundo
map <leader>u :GundoToggle<cr>

let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
colorscheme solarized

set background=dark
