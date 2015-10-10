let useLineNumbers = 0
let useRuler       = 0

au VimEnter * if empty(expand('%')) | set buftype=nofile | endif

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
set titleold="terminal"

set expandtab
set smarttab
set shiftwidth=2
set tabstop=8
set wrap
set textwidth=80

set wildmenu
set wildmode=list:longest,full

set wildignore =*.o,*.pyc,.DS_Store,*.git/*,node_modules/*

" this looks odd, but it is just setting
" my <leader> to <space>
nnoremap <space> <nop>
let mapleader = " "

au VimResized * :wincmd =

" [plugins section]
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' " surround text objects with characters
Plug 'camelcasemotion'
Plug 'joshhartigan/SimpleCommenter'
Plug 'kana/vim-niceblock' " blockwise visual mode, but better
Plug 'Raimondi/delimitMate' " delimiter auto-matching
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " auto complete 'end' keywords
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-syntax-extra' " better for C
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/neocomplete.vim' " autocompletion
Plug 'justinmk/vim-sneak'
Plug 'pangloss/vim-javascript' " better syntax
Plug 'nelstrom/vim-mac-classic-theme' " color scheme
call plug#end()

" start interactive easyalign in visual mode
vmap <enter> <plug>(EasyAlign)

nnoremap <leader>\ :NERDTreeToggle<cr>

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" [end plugins section]

nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

nnoremap N 9j
vnoremap N 9j
nnoremap M 9k
vnoremap M 9k

cnoremap <c-a> <home>
cnoremap <c-e> <end>

inoremap <esc><esc> <esc>:echoerr 'PRESS ESCAPE ONCE AND ONCE ONLY!'<cr>
cnoremap <esc><esc> <esc>:echoerr 'PRESS ESCAPE ONCE AND ONCE ONLY!'<cr>

set scrolloff=3

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap n nzz

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

set background=light
color mac_classic

set guifont=Consolas:h13

let g:loaded_matchparen=1

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

nnoremap <leader>w <c-w>

if useRuler
    set cc=80
else
    set cc=0
endif

set foldmethod=marker
set foldmarker={,}
set foldlevelstart=100

fun! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif

autocmd FileWritePre * :call TrimWhiteSpace()

set nobackup
set writebackup
set noswapfile

au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

au BufEnter *.js syn match Function 'require'

au BufNewFile,BufRead,BufWrite *.md set filetype=markdown
au BufNewFile,BufRead,BufWrite *.rs set filetype=rust

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>v :sp ~/.vimrc<cr>

set statusline=(\ %f\ ) " filepath
set statusline+=\ %n " buffer number
set statusline+=%M " modified?
set statusline+=\ %r " readonly?
set statusline+=\ %h " help file?
set statusline+=%=
set statusline+=\ %y " file type
set statusline+=\ [%c " column number
set statusline+=,\ %l " line number
set statusline+=\ of
set statusline+=\ %L] " line count

highlight StatusLine ctermbg=11 ctermfg=0 cterm=italic

nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"if $TERM_PROGRAM =~ "iTerm"
"  let &t_SI = "\<esc>]50;CursorShape=1\x7"
"  let &t_EI = "\<esc>]50;CursorShape=0\x7"
"  " return to thin cursor on exit
"  au VimLeave * let &t_EI = "\<esc>]50;CursorShape=1\x7"
"endif
