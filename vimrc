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

Bundle 'kien/ctrlp.vim'
Bundle "scrooloose/nerdtree"
Bundle "Lokaltog/vim-easymotion"

Bundle "bling/vim-airline"

" Color schemes
Bundle 'altercation/vim-colors-solarized'
Bundle "tomasr/molokai"
Bundle "Lokaltog/vim-distinguished"

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "tomtom/tcomment_vim"
Bundle "rking/ag.vim"

Bundle 'ervandew/supertab'
Bundle "valloric/YouCompleteMe"
Bundle "sirver/UltiSnips"
" Bundle "garbas/vim-snipmate"

Bundle "christoomey/vim-tmux-navigator"

" Optional:
Bundle "honza/vim-snippets"

filetype plugin indent on

let mapleader=","

set backspace=indent,eol,start
set cursorline
set expandtab
set modelines=2
set shiftwidth=3
if exists('$TMUX')
  set clipboard=
else
   set clipboard=unnamed
endif
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

" Some Mappings
nnoremap <leader>ev :split ~/dotfiles/vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Quick ESC
" inoremap jj <esc>
inoremap jk <esc>
inoremap kj <esc>

" better newline
inoremap <c-j> <esc>o

" Jump to the next row on long lines
noremap <Down> gj
noremap <Up>   gk
nnoremap j gj
nnoremap k gk

" Highlilght last inserted text
nnoremap gV `[v`]

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<cr>

" shortcuts for windows
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>s <C-w>s
" nnoremap <leader>vsa :vert sba<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Format the entire file
nnoremap <leader>fef ggVG=

" CtrlP
let g:ctrlp_clear_cache_on_exit=1
let g:ctrlp_max_height=40
let g:ctrlp_show_hidden=0
let g:ctrlp_follow_symlinks=1
let g:ctrlp_max_files=1000
let g:ctrlp_max_depth = 5
let g:ctrlp_custom_ignore = {
         \ 'dir': '\v[\/]\.(git|hg|svn|idea)$',
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
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeFind<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_collect_identifiers_from_tags_files = 1 " let YCM read tags from Ctags file
let g:ycm_use_ultisnips_compelter = 1
let g:ycm_seed_identifiers_with_syntax = 1 " complete for programmming language keywords
let g:ycm_complete_in_comments = 1 " complete in comments
let g:ycm_complete_in_strings = 1 " completion in strings

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltisnipsListSnippets = "<c-k>" " List possible snippets based on current file


" Gundo
noremap <leader>u :GundoToggle<cr>

" Airline
let g:airline_powerline_fonts=1

" toggle paste
map <F6> :set invpaste<CR>:set paste?<CR>
" remap arrow keys
nnoremap <left> :bprev<cr>
nnoremap <right> :bnext<cr>
nnoremap <up> :tabnext<cr>
nnoremap <down> :tabprev<cr>

" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

"noremap noremap "
syntax on
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
let g:solarized_termtrans = 1
colorscheme solarized

set background=dark

" add mouse to terminal
set ttyfast
set mouse=a
set mousehide
set ttymouse=xterm2
