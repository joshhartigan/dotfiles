" .vimrc
" Author: Josh Hartigan
" Source: https://github.com/joshhartigan/dotfiles/blob/master/.vimrc
" Updated: September 21 2014

" Basic options                                          {{{

let $VIMRC = "~/.vimrc"

set encoding=utf-8
set autoindent             " copy indent from current line onto next
set smartindent            " better indentaion with C-like (i.e. { }) languages
set hidden                 " hide buffer when it is abandoned
set ttyfast                " imporove redrawing smoothness
set backspace=indent,eol,start " allow backspacing over indent, eol, sol
set nonumber               " don't show line numbers
set laststatus=2           " always show status line (good for airline)
set history=1000           " remember 1000 ':' commands
set list                   " show special characters, see below
set listchars=tab:▸\ ,extends:❯,precedes:❮ " these are the special characters
set showbreak=↪            " show this character on folded lines
set matchtime=3            " highlight parentheses for 30 1/10s of a second
set splitright             " vertically split windows onto the right side
set title                  " set window name to 'titlestring' or default
set linebreak              " wrap lines only at 'breakat' characters
set ruler                  " show positional ruler in status line
set noerrorbells           " remove any annoying sounds / flashes (1)
set novisualbell           "                                      (2)
set t_vb=                  "                                      (3)
set keywordprg=":help"     " use vim-help with <K>, rather than man pages
set mouse=a                " enable mouse control

if has("breakindent")
  set breakindent          " continue indentation on wrapped lines (v7.4.338+)
endif

set expandtab      " use spaces for indentation
set smarttab       " insert 'shiftwidth' spaces and remove 'shiftwidth' spaces
set shiftwidth=2   " number of spaces for tabs / autoindent
set tabstop=8      " distinguishable from spaces in files that use tabs
set wrap           " lines longer than screen will wrap onto the next line
set textwidth=80   " break lines longer than 80 characters

set wildmenu                                " Show command-line autocompletions
set wildignore =*.o,*.pyc,.DS_Store,*.git/* " Ignore these filetypes

" Map leader to space
nnoremap <space> <Nop>
let mapleader=" "

" Resize splits equally after window resize
au VimResized * :wincmd =

" Show trailing whitespace in normal mode
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:·
    au InsertLeave * :set listchars+=trail:·
augroup END

" Make sure Vim returns to the same line when you reopen a file.
" From Steve Losh who says "Thanks, Amit"
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Vim-Plug / Plugins                                     {{{

call plug#begin('~/.vim/plugged')
" Plug 'delimitMate.vim'               " Auto-close delimiters
  Plug 'VimClojure'                    " Support for Clojure
  Plug 'ervandew/supertab'             " Word autocompletion with <tab>
  Plug 'bling/vim-airline'             " Lightweight but fancy statusline
  Plug 'hail2u/vim-css3-syntax'        " Better CSS syntax highlighting
  Plug 'jelera/vim-javascript-syntax'  " Better JavaScript syntax highlighting
  Plug 'chriskempson/base16-vim'       " A set of nice color schemes
  Plug 'tpope/vim-surround'            " Surround text objects with characters
  Plug 'camelcasemotion'               " Text objects for CamelCase words
  Plug 'mattn/emmet-vim'               " CSS Abbrevations for HTML
  Plug 'mhinz/vim-random'              " Jump to random help tags for learning
  Plug 'justinmk/vim-sneak'            " Motion - goto next s[char][char]
  Plug 'kchmck/vim-coffee-script'      " CoffeeScript support for vim
  Plug 'mintplant/vim-literate-coffeescript' " CoffeeScript support for vim
  Plug 'esneider/YUNOcommit.vim'       " Y U NO Comment after so many writes?
  Plug 'vim-scripts/haskell.vim'       " Better Haskell support for Vim
  Plug 'derekwyatt/vim-scala'          " Scala support for Vim
call plug#end()

" Don't autocomplete parentheses for Clojure or Lisp
let delimitMate_excluded_ft = "clojure,lisp"

" if has("gui_running")
"   let g:airline_powerline_fonts=1
" else
  let g:airline_powerline_fonts=0
  let g:airline_left_sep=""
  let g:airline_right_sep=""
" endif

let g:airline_detect_modified=0
" Show time in airline
let g:airline_section_b = "%{strftime('%b %d %Y %X')}"

nnoremap \ :NERDTreeToggle<cr>

" }}}
" Moving around, searching, and patterns                 {{{

" Better home/end keys - synonymous to normal movement
nnoremap H ^
nnoremap L $
vnoremap L g_

" Emacs-like Home/End in insert and command mode
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Keep current at least 30 lines away from edge of screen
set scrolloff=10

" Keep full j / k functionality on wrapped lines
nnoremap j gj
nnoremap k gk

set ignorecase " Ignore the case of letters in searches
set smartcase  " Become case-sensitive if capital letters are used in search
set hlsearch   " Highlight all search matches
set incsearch  " Place cursor at current search match
set gdefault   " Substitute all matches in a line by default

" Quicker global substitute
nnoremap <leader>h :%s/

" Clear search highlights on return press
nnoremap <cr> :nohlsearch<cr>

" Move between splits with w + hjkl, new splits with ws or wv
nnoremap w <c-w>

" }}}
" Syntax, highlighting and spelling                      {{{

" Turn syntax colouring on
syntax enable

" 256 colors enabled
set t_Co=256

if has("gui_running")
  set background=dark
  color base16-default

  " slightly customised highlighting
  highlight LineNr guibg=bg guifg=#4d4d4d
  highlight Folded guibg=bg guifg=#4d4d4d

else
  color molokai
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" }}}
" Abbreviations                                          {{{

" credit: Steve Losh
function! MakeSpacelessIabbrev(from, to)
    execute "silent! iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

call MakeSpacelessIabbrev("gh/", "https://github.com/")
call MakeSpacelessIabbrev("ghj/", "https://github.com/joshhartigan/")

" }}}
" Keybindings                                            {{{

" Copy to end of line, not all of line
nnoremap Y y$

" Switch tab
nmap <tab> :tabnext<cr>

" Create tab
nmap <leader><tab> :tabnew<cr>

" Close tab
nmap <s-tab> :tabclose<cr>

" Remove Ex mode; :q! with leader-Q
noremap Q <Nop>
nnoremap <leader>Q :q!<cr>

" Save file quickly
nnoremap b :w<cr>

" Prevent hours of time / megajoules of energy
nnoremap ; :
vnoremap ; :
nnoremap : ;

" :W as an alias to :w (a common typo)
command! W :w

" Save file that requires root permission
cmap w!! %!sudo tee > /dev/null %

" Select all text in buffer
nnoremap <leader>a ggvG

" Toggle case
nnoremap <c-u> g~iw

" Insert mode undo
inoremap <c-u> <esc>ua

" Run shell commands; print output in seperate buffer
command! -complete=shellcmd -nargs=* R belowright 15new | r ! <args>

" Inline calculator
inoremap <c-b> <c-o>yiW<end>=<c-r>=<c-r>0<cr>

" Sublime-esque indentation ([un]indent; reselect)
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Insert line between braces / parentheses
inoremap {<cr> {<cr>}<c-o>O
inoremap (<cr> (<cr>)<c-o>O

" Reload .vimrc on command
nnoremap <leader>u :source ~/.vimrc<cr>

" Soure current line / selection
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Show current highlight group/s
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" % is too far away
nnoremap ) %

" }}}
" Interface                                              {{{

" Better looking splits
set fillchars+=vert:│
if has("gui_running")
  highlight vertsplit guibg=bg guifg=#999999 ctermbg=bg ctermfg=white
endif

" Cursorline only in current window, only in normal mode (Steve Losh)
"if has("gui_running")
"  augroup cline
"  au!
"  au WinLeave,InsertEnter * set nocursorline
"  au WinEnter,InsertLeave * set cursorline
"  augroup END
"end

" More stand-out cursor (it's orange!)
highlight Cursor guibg=#FEC52E

" Ruler at column 80
if has("gui_running") " I don't like colorcolumn in terminals
  set cc=80
endif

" Set font for MacVim / gVim
if has("gui_running")
" set guifont=Menlo\ for\ Powerline:h12
set guifont=Mensch:h14

" Use italics for certain words
highlight Comment gui=italic
highlight Identifier gui=italic,bold
highlight Constant gui=italic

" Highlight Markdown / HTML as it should be
highlight htmlItalic gui=italic
highlight htmlBold gui=bold

" Minimalise gvim/macvim interface
set guioptions+=c " Use console dialogs instead of popups for choices
set guioptions-=m " Hide menu bar
set guioptions-=r " Never show vertical scrollbar
set guioptions-=b " Never show horizontal scrollbar
set guioptions-=T " Hide ugliest toolbar ever
set guioptions-=R " Don't show right scrollbar with vsplits
set guioptions-=L " Don't show left scrollbar with vsplits

" Always show tabs
set showtabline=2

" 'Thanks for flying Vim'
set notitle

" Set size to 91 x 28
" set columns=91
" set lines=28
endif

set linespace=2

" }}}
" Text and file formatting and folds                     {{{

" Use foldmarker folding method (three braces to open and close)
set foldmethod=marker

" Simple fold-toggle bindings
nnoremap § za
vnoremap § za

function! MyFoldText() " Steve Losh's, with Modifications
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 1
  return line . ' ↴ ' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" Remove trailing whitespace on save
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()


" }}}
" Backups                                                {{{

set undodir=~/.vim/undo      " undo-change files

set nobackup                 " disable backups
set writebackup              " make backup before overwriting, until save

set noswapfile               " literally no point.

" }}}
" Filetype Specific                                      {{{

" Usually .txt or .md is for documentation / info, in which
" case I will want spellchecking on.
au WinEnter *.{md,txt} set spell
au WinLeave *.{md,txt} set nospell

" Auto golang formatting
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" 'puts' is used for debugging a lot, so I make it more visible.
au BufEnter *.rb syn match Function 'puts'

" I use the string and vector types often in c++
au BufWrite *.{cc,cpp,cxx} syn match Type /string/
au BufWrite *.{cc,cpp,cxx} syn match Type /vector/

" Convert markdown link to HTML link (anywhere in line)
nnoremap <leader>ml F[i<a href=""><esc>f[xf]xi</a><esc>ldi(2F"pf(xx

" I don't use modula2, but I do use markdown.
au BufNewFile,BufRead,BufWrite *.md set filetype=markdown

" }}}
" Quick-Open Files                                       {{{

nnoremap <leader>ev :e $VIMRC<cr>
nnoremap <leader>eb :e ~/.bash_profile<cr>
nnoremap <leader>ep :cd $PROJECTS/

" .vimrc in split
nnoremap <leader>v :sp $VIMRC<cr>

" }}}
" Show Indentation Depth                                 {{{

nn <silent> <leader>B :cal BlockColor(8, 0x101010)<cr>

func! BlockColor(max, step, ...)
  let [max, bufnr] = [a:max, bufnr('%')]
  " Colors
  if !exists('g:colors_name') | let g:colors_name = 'default' | endif
  if !exists('g:bc_highl') || ( exists('g:bc_highl') && g:bc_highl != g:colors_name )
    if !exists('a:1')
      redi => gnorm
      sil! hi Normal
      redi END
      let bgc = matchstr(gnorm, 'guibg=#\zs[^# ]\+')
      let bgc = empty(bgc) ? &bg == 'dark' ? '0x000000' : '0xffffff' : '0x'.bgc
    else
      let bgc = a:1
    endif
    for id in range(1, max)
      let step = &bg == 'dark' ? bgc + (a:step * id) : bgc - (a:step * id)
      exe 'hi BlockColor'.id.' guifg=bg guibg=#'.s:gethex(step)
    endfor
    let g:bc_highl = g:colors_name
  endif
  " Toggling
  if exists('b:blockcolor') && b:blockcolor
    let b:blockcolor = 0
    for id in range(1, max)
      sil! cal matchdelete(bufnr.id)
    endfor
  else
    let b:blockcolor = 1
    for id in range(1, max)
      cal matchadd('BlockColor'.id, '^\s\{'.id.'}', id, bufnr.id)
    endfor
  endif
endfunc

func! s:gethex(step)
  let newco = printf('%x', a:step)
  let newco = strlen(newco) < 6 ? s:padzero(newco) : newco
  let newco = '0x'.newco >= 0xffffff ? 'ffffff' : newco
  let newco = '0x'.newco <= 0 ? '000000' : newco
  retu newco
endfunc

func! s:padzero(nr)
  let [nr, len] = [a:nr, 6 - strlen(a:nr)]
  for each in range(1, len)
    let nr = '0'.nr
  endfor
  retu nr
endfunc

" }}}
