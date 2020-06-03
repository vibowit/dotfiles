"
" ==== Plugin Setup ====
"
call plug#begin('~/.vim/plugged')
  Plug 'dracula/vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'jiangmiao/auto-pairs'
  "Plug 'SirVer/ultisnips'
  "Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()

"
" ==== BASIC SETTINGS ====
"
set autoread
set number relativenumber
set wildmenu
set spelllang=pl_PL
set backspace=indent,eol,start
set noruler
set cursorline
set confirm
syntax enable
" colorscheme dracula
set termguicolors
" open new split panes to right and below
set splitright
set splitbelow
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
" set colorcolumn=81
set noemoji
set nobackup
set noswapfile

"
" ==== Leader settings and mappings ====
"
let mapleader = "\<Space>"
nnoremap <Leader><space> :noh<cr>
nnoremap Y y$
nnoremap <F2> :ls<cr>:b  

map <s-enter> :call confirm("this Control-Enter mapping works")<cr>

"
" ==== Terminal Settings ====
"
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 1
endfunction
nnoremap <C-n> :call OpenTerminal()<CR><Paste>

"
" ==== Colorscheme ====
"
colorscheme nord

"
" ==== Airline ====
"
let g:airline_powerline_fonts = 1

"
" ==== FZF ====
"
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" ==== vim-go ====
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
nnoremap <silent> <leader>t :GoTest<cr>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
