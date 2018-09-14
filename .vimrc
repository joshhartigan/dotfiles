let useLineNumbers   = 1
let useRuler         = 0
let useCursorLine    = 0
let permanentTabline = 0
let noBufTabLine     = 1

" [basic config] {{
" this lets me start writing immediately,
" without having to write to a file
au VimEnter * if empty(expand('%')) | set buftype=nofile | endif

if useCursorLine
  set cursorline
else
  set nocursorline
endif

if useRuler
    set cc=80
else
    set cc=0
endif

set encoding=utf-8
set smartindent
set autoindent
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
set splitbelow
set linebreak
set ruler
set noerrorbells
set novisualbell
set t_vb=
set list
set listchars=tab:▸\ ,
set mouse=a

if has('breakindent')
    set breakindent
endif

set showcmd
set showmatch
set title
set titleold="terminal"

set expandtab
set smarttab
set shiftwidth=2
set tabstop=8
set wrap
set showbreak=‣

set textwidth=0 " break text after this point

set wildmenu
set wildmode=list:longest,full

set wildignore =*.o,*.pyc,.DS_Store,*.git/*,node_modules/*,*.class

" use <space> as leader
nnoremap <space> <nop>
let mapleader = " "

au VimResized * :wincmd =

" file explorer
nnoremap \ :Lex<cr>
" [end basic config] }}

" [plugins] {{
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'kana/vim-niceblock'
Plug 'Raimondi/delimitMate'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-syntax-extra' " for C
Plug 'pangloss/vim-javascript'
Plug 'haya14busa/incsearch.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'ap/vim-buftabline'
Plug 'ajh17/VimCompletesMe'
" [color schemes]
Plug 'junegunn/seoul256.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-vividchalk'
Plug 'blueshirts/darcula'
Plug 'morhetz/gruvbox'
Plug 'nelstrom/vim-mac-classic-theme'
Plug 'zanglg/nova.vim'
Plug 'chriskempson/base16-vim'
call plug#end()

if permanentTabline
  set showtabline=2
  let g:buftabline_show = 2
else
  set showtabline=1
  let g:buftabline_show = 1
endif

if noBufTabLine
  let g:buftabline_show = 0
endif

" start interactive easyalign in visual mode
vmap <enter> <plug>(EasyAlign)

" configuration for incsearch.vim
map / <Plug>(incsearch-forward)

let g:loaded_matchparen=1

filetype plugin on
filetype indent on

" [end plugins section] }}

" [movement mappings and options] {{
cnoremap <c-a> <home>
cnoremap <c-e> <end>

set scrolloff=6

nnoremap j gj
nnoremap k gk

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

nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap N 9j
vnoremap N 9j
nnoremap M 9k
vnoremap M 9k

" searching / searching mappings
nnoremap n nzz

set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault

nnoremap <leader><cr> :let @/ = ""<cr>

nnoremap * *:let @/ = ""<cr>
nnoremap # #:let @/ = ""<cr>

nnoremap ci_ T_ct_

nnoremap Y y$

nnoremap , ;
nnoremap < ,

nnoremap ; :
vnoremap ; :

nnoremap <leader>a ggVG
nnoremap <leader>c ggVG"+y<cr>

nnoremap <c-u> g~iw

inoremap <c-u> <esc>ua

nnoremap <leader>p :set paste!<cr>:set paste?<cr>

nnoremap S i<cr><esc>k$
" [end movement mappings and options] }}

" [colours] {{
let base16colorspace=256
colorscheme base16-monokai
highlight LineNr ctermbg=bg
" [end colours] }}

" [window/buf management] {{
nmap <tab> :bnext<cr>
nmap <leader><tab> :bprevious<cr>

nnoremap <leader>q :bd<cr>
nnoremap Q :q<cr>
nnoremap <leader>Q :q!<cr>

" update only writes the file if there's been changes
nnoremap <backspace> :update<cr>

cmap w!! %!sudo tee > /dev/null %

nnoremap s <c-w>
" resize current window<
nnoremap <s-right> <C-w>>
nnoremap <s-left> <c-w><
set foldmethod=marker

set foldmarker={,}
autocmd BufEnter *vimrc set foldmarker={{,}}
autocmd BufLeave *vimrc set foldmarker={,}

set foldlevelstart=100
nnoremap § za

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

set nobackup
set writebackup
set noswapfile
" [end window/buf management] }}

" [filetype specific] {{
if (&ft != 'clojure' && &ft != 'lisp')
    inoremap {<cr> {<cr>}<c-o>O
    inoremap (<cr> (<cr>)<c-o>O
    inoremap ({<cr> ({<cr>})<c-o>O
endif

au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

au BufEnter *.js syn match Function 'require'

au BufNewFile,BufRead,BufWrite *.md set filetype=markdown
au BufNewFile,BufRead,BufWrite *.rs set filetype=rust

au BufEnter *.{cc,cpp} inoremap ;; ::

au BufEnter *.html inoremap [[i <i>
au BufEnter *.html inoremap ]]i </i>

" for editing vimrc:
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>v :sp ~/.vimrc<cr>
" [end filetype specific] }}

" [statusline] {{

" left hand side
set statusline=(\ %f\ ) " filepath
set statusline+=\ %n " buffer number
set statusline+=%M " modified
set statusline+=%="
" right hand side
set statusline+=\ %l " line number
set statusline+=\ of
set statusline+=\ %L " line count
set statusline+=\ %r " readonly?
set statusline+=\ %h " help file?

" [end statusline section] }}

" [gui options] {{

set guioptions-=r " don't always show scrollbar
set guioptions-=L " ditto
set guioptions-=e " don't use gui tabs

hi rplCursor guibg=red  guifg=black
hi visCursor guibg=cyan guifg=black

" hi TabLine guibg=#444444
hi Todo guibg=bg guifg=#ffffff gui=italic

" [end gui options section] }}

" [ide mode] {{

" marker - <++>
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

autocmd FileType html inoremap ;i <em></em><Space><++><Esc>FeT>i

" [end ide mode] }}

nnoremap <leader>u :source ~/.vimrc<cr>
