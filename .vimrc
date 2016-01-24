let useLineNumbers   = 1
let useRuler         = 1
let permanentTabline = 1

" this lets me start writing immediately,
" without having to write to a file
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
set nowrap
set textwidth=80 " break text after this point

set wildmenu
set wildmode=list:longest,full

set wildignore =*.o,*.pyc,.DS_Store,*.git/*,node_modules/*,*.class

" this looks odd, but it is just setting
" my <leader> to <space>
nnoremap <space> <nop>
let mapleader = " "

" for when I can't use <capslock> for some reason
" inoremap jk <esc>
" inoremap kj <esc>

au VimResized * :wincmd =

" [plugins section]
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround' " surround text objects with characters
Plug 'camelcasemotion'
Plug 'kana/vim-niceblock' " blockwise visual mode, but better
Plug 'Raimondi/delimitMate' " delimiter auto-matching
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " auto complete 'end' keywords
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-syntax-extra' " better for C
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript' " better syntax
Plug 'haya14busa/incsearch.vim' " show all search results
Plug 'ervandew/supertab' " sipmle autocompletion
Plug 'altercation/vim-colors-solarized'
Plug 'croaky/vim-colors-github'
Plug 'biogoo.vim'
call plug#end()

" start interactive easyalign in visual mode
vmap <enter> <plug>(EasyAlign)

" configuration for incsearch.vim
map / <Plug>(incsearch-forward)

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

set scrolloff=3

" movement mappings
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

" text editing mappings

nnoremap ci_ T_ct_

" colours
colorscheme macvim

hi VertSplit cterm=NONE
hi htmlItalic cterm=NONE ctermfg=9

let g:loaded_matchparen=1

filetype plugin on
filetype indent on

" abbreviations
iabbrev psvm public static void main(String args[]) {<cr>
iabbrev #i #include
iabbrev #d #define
iabbrev req require("

nnoremap Y y$

if permanentTabline
  set showtabline=2
else
  set showtabline=1
endif

nmap <tab> :tabnext<cr>
nmap <leader><tab> :tabprevious<cr>
nmap <s-tab> :tabnew<cr>

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

nnorem ap S i<cr><esc>k$

nnoremap <leader>w :echo "Use S"<cr>
nnoremap s <c-w>
" resize current window<
nnoremap <s-right> <C-w>>
nnoremap <s-left> <c-w><

if useRuler
    set cc=80
else
    set cc=0
endif

set foldmethod=marker
set foldmarker={,}
set foldlevelstart=100
nnoremap § za

fun! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif

autocmd FileWritePre * :call TrimWhiteSpace()

set nobackup
set writebackup
set noswapfile

au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

au BufEnter *.js syn match Function 'require'

au BufNewFile,BufRead,BufWrite *.md set filetype=markdown
au BufNewFile,BufRead,BufWrite *.rs set filetype=rust

" automatically insert header gates
function! s:insert_gates()
  let gate_name = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gate_name
  execute "normal! o#define " . gate_name . "\n\n\n"
  execute "normal! Go#endif"
  normal! kk
endfunction

autocmd BufNewFile *.h call <SID>insert_gates()

nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>v :sp ~/.vimrc<cr>

" [statusline section]

" left hand side
set statusline=(\ %f\ ) " filepath
set statusline+=\ %n " buffer number
set statusline+=%M " modified"
set statusline+=\ %r " readonly?
set statusline+=\ %h " help file?
" right hand side
set statusline+=%="
set statusline+=\ %{strftime(\"%H:%M\")}
set statusline+=\ %y " file type
set statusline+=\ %l " line number
set statusline+=\ of
set statusline+=\ %L " line count


" [end statusline section]

nnoremap <F8> :echo "group: " .
    \ synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")<CR>

" [gui options section]

set guioptions-=r " don't always show scrollbar

hi rplCursor guibg=red  guifg=black
hi visCursor guibg=cyan guifg=black

set guicursor=n:blinkwait700-blinkon500-blinkoff400-block,i:blinkon0-ver20,v:blinkwait200-blinkon200-blinkoff200-visCursor,r:hor30-rplCursor-blinkon0

" [end gui options section]
