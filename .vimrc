let useLineNumbers = 0
let useCursorLine  = 0
let useRuler       = 0

set encoding=utf-8
set autoindent
set smartindent
set hidden
set ttyfast
set backspace=indent,eol,start

if useLineNumbers
  set number
else
  set nonumber
endif

set laststatus=2
set history=1000
set splitright
set linebreak
set ruler
set noerrorbells
set novisualbell
set t_vb=
set keywordprg=":help"
set list
set listchars=tab:▸\ ,
set mouse=a

if has('breakindent')
  set breakindent
endif

set showcmd
set showmatch
set title

if useCursorLine
  set cursorline
else
  set nocursorline
endif

set expandtab
set smarttab
set shiftwidth=4
set tabstop=8
set wrap
set textwidth=80

set wildmenu

set wildignore =*.o,*.pyc,.DS_Store,*.git/*,node_modules/*

" this looks odd, but it is just setting
" my <leader> to <space>
nnoremap <space> <nop>
let mapleader = " "

au VimResized * :wincmd =

" [plugins section]
call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim' " writeroom style in Vim
Plug 'bling/vim-bufferline' " show list of buffers in statusline
Plug 'tpope/vim-surround' " surround text objects with characters
Plug 'camelcasemotion' " text objects for CamelCase words
Plug 'joshhartigan/SimpleCommenter' " comment out lines simply
Plug 'kana/vim-niceblock' " blockwise visual mode, but better
Plug 'Raimondi/delimitMate' " delimiter auto-matching
Plug 'bronson/vim-trailing-whitespace' " show trailing whitespace
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " auto complete 'end' keywords
Plug 'junegunn/vim-easy-align' " align stuff (easily)
Plug 'ervandew/supertab' " autocompletion
Plug 'justinmk/vim-syntax-extra' " better for C
Plug 'kien/ctrlp.vim' " fuzzy file finder
call plug#end()

" start interactive easyalign in visual mode
vmap <enter> <plug>(EasyAlign)
" [end plugins section]

nnoremap H ^
nnoremap L $
nnoremap L $

nnoremap N 9j
vnoremap N 9j
nnoremap M 9k
vnoremap M 9k

cnoremap <c-a> <home>
cnoremap <c-e> <end>

set scrolloff=30

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

nnoremap <leader><cr> :let @/ = ""<cr>

nnoremap * *:let @/ = ""<cr>
nnoremap # #:let @/ = ""<cr>

inoremap <right> <esc>>>a
inoremap <left>  <esc><<a
inoremap <up>    <esc>ddkPi
inoremap <down>  <esc>ddpi

nnoremap <right> <esc>>>
nnoremap <left>  <esc><<
nnoremap <up>    <esc>ddkP
nnoremap <down>  <esc>ddp

vnoremap <right> >gv
vnoremap <left> <gv

syntax on
set t_Co=256

set background=dark

filetype plugin on
filetype indent on

iabbrev psvm public static void main(String args[]) {<cr>

nnoremap gcc :SimpleComment<cr>
nnoremap guc :SimpleUncomment<cr>

nnoremap Y y$

nmap <tab> :bnext<cr>

nnoremap Q :q<cr>
nnoremap <leader>Q :q!<cr>

nnoremap <backspace> :w<cr>

nnoremap , ;
nnoremap < ,

nnoremap ; :
vnoremap ; :

cmap w!! %!sudo tee > /dev/null %

nnoremap <leader>a ggVG

nnoremap <c-u> g~iw

inoremap <c-u> <esc>ua

if (&ft != 'clojure' && &ft != 'lisp')
  inoremap {<cr> {<cr>}<c-o>O
  inoremap (<cr> (<cr>)<c-o>O
  inoremap ({<cr> ({<cr>})<c-o>O
endif

nnoremap <leader>u :source ~/.vimrc<cr>

nnoremap <leader>p :set paste!<cr>:set paste?<cr>

nnoremap S i<cr><esc>k$

if useRuler
  set cc=80
else
  set cc=0
endif

set foldmethod=syntax
set foldlevelstart=100

nnoremap ` za
vnoremap ` za

fun! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd FileWritePre * :call TrimWhiteSpace()

set nobackup
set writebackup
set noswapfile

au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

au BufNewFile,BufRead,BufWrite *.md set filetype=markdown

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>v :sp ~/.vimrc<cr>
