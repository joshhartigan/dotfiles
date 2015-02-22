" -*- use neovim on mac -*-
if has('mac') && !has('macvim') && !has('nvim')
  echo "please use neovim"
endif

" accessible values for features that I toggle a lot
let useCursorLine = 1
  let cursorLineOnlyInNormal = 0
let useSpellCheck = 0

" start vim with a scratch buffer when it isn't supplied
" with any arguments, just like emacs
au VimEnter * if empty(expand('%')) | set buftype=nofile | endif

" CONTENTS (press * on md5):
"   basic options       - 790119dc20c9c88fafb8c1387a215939
"   plugins             - ee114926568bfaed70b982a47c8be743
"   moving around etc.  - 0a272fef246e9a1ccbcd41430d1c8fa5
"   syntax etc.         - e1150751eabad1616657096d1fc161e8
"   abbreviations       - 6ba63c409ec6ad4418d5a0fe73986bc5
"   keybindings         - 1ec442eb14483faf21f007d4672977f5
"   interface           - 78ceb1219085f26b5b14667ad54e68fb
"   text and files etc. - c1b2b7a346e9bfea3307cbd4a6e8bf5d
"   backups             - d65afaadb40c8ecfab29b38d74ed9190
"   filetype specific   - 90aca44b20c4fec7cc326e3e6d5c8265
"   quick-open files    - c2b048731a310a5e20498aa324634ca0
"   functions / misc    - c938316bde540963a92a96a0bcd481c9

" ------------------------------------------------
" basic options @ 790119dc20c9c88fafb8c1387a215939
" ------------------------------------------------

" information on 'nocompatible':
"       many people recommend `set nocompatible` to
"       be at the first line of a .vimrc file. However,
"       If a vimrc or gvimrc file is found during startup,
"       vim will automatically set 'nocompatible'.
"               see :h 'cp' for more information

let $VIMRC = "~/.vimrc"

set encoding=utf-8         " welcome to the 21st century
set autoindent             " copy indent from current line onto next
set smartindent            " better indentaion with C-like (i.e. { }) languages
set hidden                 " hide buffer when it is abandoned
set ttyfast                " improve redrawing smoothness
set backspace=indent,eol,start " allow backspacing over indent, eol, sol
set nonumber               " don't show line numbers
set laststatus=2           " always show statusline
set history=1000           " remember 1000 ':' commands
set showbreak=↪            " show this character on folded lines
set splitright             " vertically split windows onto the right side
set notitle                " don't set window name to 'titlestring' or default
set titlestring="~ vim ~"  " ... this is the title string
set linebreak              " wrap lines only at 'breakat' characters
set ruler                  " show positional ruler in status line
set noerrorbells           " remove any annoying sounds / flashes (1)
set novisualbell           "                                      (2)
set t_vb=                  "                                      (3)
set keywordprg=":help"     " use vim-help with <K>, rather than man pages
set list                   " show special characters, see below
set listchars=tab:▸\ ,extends:❯,precedes:❮
set mouse=a                " enable mouse control for all modes
set breakindent            " continue indentation on wrapped lines (v7.4.338+)
set showcmd                " show info on in-progress commmands (:help showcmd)
set showmatch              " in insert mode, show matching brackets...
set matchtime=3            " ...for 3/10s of a second

if useCursorLine
  set cursorline
else
  set nocursorline
endif

set expandtab      " use spaces for indentation
set smarttab       " insert 'shiftwidth' spaces and remove 'shiftwidth' spaces
set shiftwidth=2   " number of spaces for tabs / autoindent
set tabstop=8      " distinguishable from spaces in files that use tabs
set wrap           " lines longer than screen will wrap onto the next line
set textwidth=80   " break lines longer than 80 characters

set wildmenu       " Show command-line autocompletions

" Ignore these filetypes:
set wildignore =*.o,*.pyc,.DS_Store,*.git/*,.node_modules/*

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


" -----------------------------------------------------
" vim-plug / plugins @ ee114926568bfaed70b982a47c8be743
" -----------------------------------------------------

" Required by vim-plug
call plug#begin('~/.vim/plugged')

" Interface ---------------------------------------------------------------
Plug 'itchyny/vim-highlighturl'      " URL highlight everywhere
Plug 'joshhartigan/midnight.vim'     " A color scheme
Plug 'junegunn/goyo.vim'             " Writeroom style in Vim
Plug 'itchyny/lightline.vim'         " A light statusline
Plug 'kien/rainbow_parentheses.vim'  " Coloured matching brackets
Plug 'noctu.vim'                     " Adaptive color scheme
Plug 'joshhartigan/vim-showcolors'   " Show all possible color options
Plug 'tomasr/molokai'                " Famous color scheme
Plug 'Yggdroot/indentLine'           " Display indentation levels
" Text functionality ------------------------------------------------------
Plug 'tpope/vim-surround'            " Surround text objects with characters
Plug 'camelcasemotion'               " Text objects for CamelCase words
Plug 'joshhartigan/SimpleCommenter'  " Comment out lines simply
Plug 'kana/vim-niceblock'            " Blockwise visual mode, but better
Plug 'ervandew/supertab'             " Autocompletion simpler than YCM or NC
Plug 'Raimondi/delimitMate'          " Delimiter auto-matching
" Web Functionality -------------------------------------------------------
Plug 'ryanss/vim-hackernews'         " Browse HN within Vim
Plug 'mattn/webapi-vim'              " Dependency for gist-vim
Plug 'mattn/gist-vim'                " Post buffer/selection to Gist
Plug 'joshhartigan/vim-reddit'       " Browse reddit in Vim
" Language Support --------------------------------------------------------
Plug 'scrooloose/syntastic'          " Syntax checking for Vim
Plug 'joshhartigan/node.vim'         " Run javascript inside vim
Plug 'pangloss/vim-javascript'       " Improved JS syntax
" Other functionality -----------------------------------------------------
Plug 'mhinz/vim-random'              " Jump to random help tags for learning
Plug 'esneider/YUNOcommit.vim'       " Y U NO Comment after so many writes?
Plug 'loremipsum'                    " Insertion of dummy text
Plug 'kien/ctrlp.vim'                " Fuzzy file finder
" -------------------------------------------------------------------------

" All plugins must be inserted before this line
call plug#end()

" Plugin options can go after this point
au VimEnter * RainbowParenthesesToggle " Turn rainbows on always
au VimEnter * RainbowParenthesesLoadSquare " Including for square brackets

let g:lightline = {
      \ 'colorscheme': 'solarized_dark',
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

let javascript_enable_domhtmlcss = 1
let b:javascript_fold=1

" No delimitMate for clojure
au VimEnter *.clj DelimitMateOff

" Better mode for the molokai color scheme
let g:rehash256 = 1


" -------------------------------------------------------------------------
" moving around, searching, and patterns @ 0a272fef246e9a1ccbcd41430d1c8fa5
" -------------------------------------------------------------------------

" Better home/end keys - synonymous to normal movement
nnoremap H ^
nnoremap L $
vnoremap L $

" Move up and down a bit faster
func! Scroll(dir, distance)
  for i in range(a:distance)
    let start = reltime()
    if a:dir ==# 'd'
      normal! j
    elseif a:dir ==# 'u'
      normal! k
    endif
    redraw
    let so_far = s:millisecs_since(start)
    let duration = 30
    let wait = float2nr(duration-so_far)
    if wait > 0
      exec 'sleep ' . wait . 'm'
    endif
  endfor
endfunc

command! -nargs=* Scroll call Scroll(<f-args>)

nnoremap N 9j
vnoremap N 9j
nnoremap M 9k
vnoremap M 9k

" Emacs-like Home/End in insert and command mode
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Keep the current line 20 lines from the ends of the screen
set scrolloff=20

" Keep full j / k functionality on wrapped lines
" and use gj / gk for default functionality
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

set ignorecase " Ignore the case of letters in searches
set smartcase  " Become case-sensitive if capital letters are used in search
set hlsearch   " Highlight all search matches
set incsearch  " Place cursor at current search match
set gdefault   " Substitute all matches in a line by default

" Quicker global substitute
nnoremap <leader>h :%s/

" Clear search highlights on space+return
" (rather than :nohlsearch, this actually 'forgets'
" what you have searched for)
nnoremap <leader><cr> :let @/ = ""<cr>

" Move between splits with s + hjkl, new splits with ss or sv
nnoremap s <c-w>

" Don't highlight results from * and #
nnoremap * *:let @/ = ""<cr>
nnoremap # #:let @/ = ""<cr>

" I forgot about these keys
inoremap <right> <esc>>>a
inoremap <left>  <esc><<a
inoremap <up>    <esc>ddkPa
inoremap <down>  <esc>ddpa

nnoremap <right> <esc>>>
nnoremap <left>  <esc><<
nnoremap <up>    <esc>ddkP
nnoremap <down>  <esc>ddp

" This allows one less keypress for going to line X
" e.g. 151\ will take me to line 151.
nnoremap \ G

" --------------------------------------------------------------------
" syntax, highlighting and spelling @ e1150751eabad1616657096d1fc161e8
" --------------------------------------------------------------------

" Turn syntax colouring on
syntax enable

" 256 colors enabled in terminal
set t_Co=256

set background=dark
color molokai

if has("gui_running")
  " Slightly customised highlighting - more subtle line numbers
  highlight LineNr guibg=bg guifg=#333333
endif

" Enable filetype plugins
filetype plugin on
filetype indent on


" ------------------------------------------------
" abbreviations @ 6ba63c409ec6ad4418d5a0fe73986bc5
" ------------------------------------------------

" credit: Steve Losh
function! EatChar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

function! MakeSpacelessIabbrev(from, to)
    execute "silent! iabbrev <silent> ".a:from." ".a:to."<C-R>=EatChar('\\s')<CR>"
endfunction

call MakeSpacelessIabbrev("gh/", "https://github.com/")
call MakeSpacelessIabbrev("ghj/", "https://github.com/joshhartigan/")

call MakeSpacelessIabbrev("cl", "console.log(")
call MakeSpacelessIabbrev("req", "require('")


" ----------------------------------------------
" keybindings @ 1ec442eb14483faf21f007d4672977f5
" ----------------------------------------------

" Some keybindings are in other folded sections of this file,
" because they suit a more specific category (e.g. folding)

nnoremap gcc :SimpleComment<cr>
nnoremap guc :SimpleUncomment<cr>

" Copy to end of line, not all of line
nnoremap Y y$

" Switch tab
nmap <tab> :tabnext<cr>

" Create tab
nmap <leader><tab> :tabnew<cr>

" Close tab
nmap <s-tab> :tabclose<cr>

" Remove Ex mode; :q! with leader-Q
noremap Q :q<cr>
nnoremap <leader>Q :q!<cr>

" Save file quickly
nnoremap b :w<cr>

" Use , rather than ; for repeating f/t/F/T motions
nnoremap , ;
" And use < to go backwards
nnoremap < ,

" Prevent hours of time / megajoules of energy
nnoremap ; :
vnoremap ; :

" :W as an alias to :w (a common typo)
command! W :w

" Save file that requires root permission
cmap w!! %!sudo tee > /dev/null %

" Select all text in buffer
nnoremap <leader>a ggVG

" Toggle case
nnoremap <c-u> g~iw

" Insert mode undo
inoremap <c-u> <esc>ua

" Run shell commands; print output in seperate buffer
command! -complete=shellcmd -nargs=* R belowright 15new | r ! <args>

" Inline capital letter that only shows result
inoremap <c-B> <c-o>yiW<end>=<c-r>=<c-r>0<cr><esc>F=a<space><esc>hdaW

" Sublime-esque indentation in visual mode ([un]indent; reselect)
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Insert line between braces / parentheses - obsolete by delimitMate
" if (&ft != 'clojure')
"   inoremap {<cr> {<cr>}<c-o>O
"   inoremap (<cr> (<cr>)<c-o>O
"   inoremap ({<cr> ({<cr>})<c-o>O
" endif

" Reload .vimrc on command
nnoremap <leader>u :source $VIMRC<cr>:echo 'sourced vimrc'<cr>

" Source current file
nnoremap <leader>U :source %<cr>:echo 'sourced file'<cr>

" Source current line
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'sourced line'<cr>

" Show current highlight group/s - very useful for creating modifications
" to syntax highlighting.
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" % is too far away
nnoremap ( %

" Sublime text nostalgia
nnoremap <leader>P :

" Faster access for pasting text
nnoremap <leader>p :set paste!<cr>:set paste?<cr>

" The same as block-mode I/A, but for normal mode (based on indentation)
" From github/junegunn/dotfiles/.vimrc
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A

" Split line (opposite motion to joining lines with J)
nnoremap S i<cr><esc>k$


" --------------------------------------------
" interface @ 78ceb1219085f26b5b14667ad54e68fb
" --------------------------------------------

if &background == 'light'
  highlight VertSplit ctermfg=15 ctermbg=15
endif
if &background == 'dark'
  highlight VertSplit ctermfg=0 ctermbg=0
endif

" Cursorline only in current window, only in normal mode (Steve Losh)
if useCursorLine && cursorLineOnlyInNormal
  augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
  augroup END
end

" Ruler at column 80
" set cc=80

" Set font for MacVim (I only use GUI on Mac)
" Note: I rarely use GUI at all anymore - it's much more productive
"       to stay in the Terminal, where everything else is.
if has("gui_running")

  set guifont=Monaco:h12

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
  set guioptions-=e " Use non-gui tabs

  set linespace=2 " Put 2 pixels in between each line of text

endif


" Use block cursor for normal mode and thin cursor for insert mode
" (this will only work in iTerm)
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  " Upon exit, return to thin cursor
  au VimLeave * let &t_EI = "\<Esc>]50;CursorShape=1\x7"
endif

" Underline search matches rather than highlighting them
" (undercurl is rarely available, but if it isn't, it just
" subsitutes for underline :D)
highlight Search ctermbg=black ctermfg=brown cterm=undercurl


" ---------------------------------------------------------------------
" text and file formatting and folds @ c1b2b7a346e9bfea3307cbd4a6e8bf5d
" ---------------------------------------------------------------------

" Use foldmarker folding method (three braces to open and close)
set foldmethod=marker

" Simple fold-toggle bindings - the key to the left of the 'z' key
nnoremap ` za
vnoremap ` za

function! FoldLines()
  let line     = getline(v:foldstart)
  let line_len = len(line)

  let width = &tw ? &tw : 80

  let foldedlinecount = v:foldend - v:foldstart

  let fill = repeat(' ', width - line_len - 15)

  return line . fill . foldedlinecount . ' lines' . repeat(' ', 1000)
endfunction

set foldtext=FoldLines()

" Remove trailing whitespace on save
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()


" ------------------------------------------
" backups @ d65afaadb40c8ecfab29b38d74ed9190
" ------------------------------------------

set undodir=~/.vim/undo      " Undo-change files

set nobackup                 " Disable backups
set writebackup              " Make backup before overwriting, until save

set noswapfile               " I hate swap files; they must burn


" ----------------------------------------------------
" filetype specific @ 90aca44b20c4fec7cc326e3e6d5c8265
" ----------------------------------------------------

" Usually .txt or .md is for documentation / info, in which
" case I will want spellchecking on.
if useSpellCheck
  au WinEnter *.{md,txt} set spell
  au WinLeave *.{md,txt} set nospell
endif

" Auto golang formatting
autocmd FileType go autocmd BufWritePre <buffer> Fmt
" ... not that I use Go anymore. It sucks (mostly).

" 'puts' is used for debugging a lot, so I make it more visible.
au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

" I use the string and vector types often in c++, and I like colours
au BufEnter *.{cc,cpp,cxx} syn match Type /string/
au BufEnter *.{cc,cpp,cxx} syn match Type /vector/

" Highlighting almost everything in Clojure can be irritating
au BufEnter *.clj NoMatchParen

" Convert markdown link to HTML link (anywhere in line)
nnoremap <leader>ml F[i<a href=""><esc>f[xf]xi</a><esc>ldi(2F"pf(xx

" I don't use modula2, but I do use markdown.
au BufNewFile,BufRead,BufWrite *.md set filetype=markdown


" ---------------------------------------------------
" quick-open files @ c2b048731a310a5e20498aa324634ca0
" ---------------------------------------------------

" Open ~/.vimrc in same buffer
nnoremap <leader>ev :e $VIMRC<cr>

" Open ~/.bashrc in same buffer
nnoremap <leader>eb :e ~/.bashrc<cr>

nnoremap <leader>ep :cd $PROJECTS/

" Open .vimrc in split
nnoremap <leader>v :sp $VIMRC<cr>

" -----------------------------------------------------
" functions and misc @ c938316bde540963a92a96a0bcd481c9
" (any random stuff that doesn't fit anywhere else)
" -----------------------------------------------------

func! s:millisecs_since(time)
  let cost = split(reltimestr(reltime(a:time)), '\.')
  return str2nr(cost[0]) * 1000 + str2nr(cost[1]) / 1000.0
endfunc
