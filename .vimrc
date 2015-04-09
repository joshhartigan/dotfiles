" vim: set foldmethod=marker foldlevel=0:

" accessible values for features that I toggle a lot
let useLineNumbers = 0
let useCursorLine = 1
let cursorLineOnlyInNormal = 0
let useSpellCheck = 0
let melonEmoji = 1

" start vim with a scratch buffer when it isn't supplied
" with any arguments, just like emacs (except this scratch
" buffer is in markdown)
au VimEnter * if empty(expand('%')) |
      \ set buftype=nofile | setf markdown | endif

" CONTENTS (press * on md5):
"   basic options       - 790119dc20
"   plugins             - ee11492656
"   moving around etc.  - 0a272fef24
"   syntax etc.         - e1150751ea
"   abbreviations       - 6ba63c409e
"   keybindings         - 1ec442eb14
"   interface           - 78ceb12190
"   text and files etc. - c1b2b7a346
"   backups             - d65afaadb4
"   filetype specific   - 90aca44b20
"   quick-open files    - c2b048731a
"   functions / misc    - c938316bde

"790119dc20 || basic options {{{

if 0
  information on 'nocompatible':
        many people recommend `set nocompatible` to
        be at the first line of a .vimrc file. However,
        If a vimrc or gvimrc file is found during startup,
        vim will automatically set 'nocompatible'.
                see :h 'cp' for more information
endif

let $VIMRC = "~/.vimrc"

set encoding=utf-8         " welcome to the 21st century
set autoindent             " copy indent from current line onto next
set smartindent            " better indentaion with C-like (i.e. { }) languages
set hidden                 " hide buffer when it is abandoned
set ttyfast                " improve redrawing smoothness
set backspace=indent,eol,start " allow backspacing over indent, eol, sol
set norelativenumber       " helps prevent hjkl spamming

if useLineNumbers
  set number               " show the actual line number on current line
endif

set laststatus=2           " always show statusline
set history=1000           " remember 1000 ':' commands
set showbreak=↪            " show this character on folded lines
set splitright             " vertically split windows onto the right side
set linebreak              " wrap lines only at 'breakat' characters
set ruler                  " show positional ruler in status line
set noerrorbells           " remove any annoying sounds / flashes (1)
set novisualbell           "                                      (2)
set t_vb=                  "                                      (3)
set keywordprg=":help"     " use vim-help with <K>, rather than man pages
set list                   " show special characters, see below
set listchars=tab:▸\ ,
set mouse=a                " enable mouse control for all modes
if has("breakindent")
  set breakindent          " continue indentation on wrapped lines (v7.4.338+)
endif
set showcmd                " show info on in-progress commmands (:help showcmd)
set showmatch              " in insert mode, show matching brackets...
set matchtime=3            " ...for 3/10s of a second
set title                  " give the terminal a good title

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
set wildignore =*.o,*.pyc,.DS_Store,*.git/*,node_modules/*

" Map leader to space
nnoremap <space> <Nop>
let mapleader = " "

" Resize splits equally after window resize
au VimResized * :wincmd =

" }}}

"ee11492656 || plugins {{{

" Required by vim-plug
call plug#begin('~/.vim/plugged')

" Interface ---------------------------------------------------------------
Plug 'itchyny/vim-highlighturl'      " URL highlight everywhere
Plug 'junegunn/goyo.vim'             " Writeroom style in Vim
Plug 'itchyny/lightline.vim'         " A light statusline
Plug 'joshhartigan/vim-showcolors'   " Show all possible color options
Plug 'bling/vim-bufferline'          " Show list of buffers in statusline
" Color Schemes -----------------------------------------------------------
Plug 'joshhartigan/midnight.vim'
Plug 'noctu.vim'
Plug 'sjl/badwolf'
Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'
" Text functionality ------------------------------------------------------
Plug 'tpope/vim-surround'              " Surround text objects with characters
Plug 'camelcasemotion'                 " Text objects for CamelCase words
Plug 'joshhartigan/SimpleCommenter'    " Comment out lines simply
Plug 'kana/vim-niceblock'              " Blockwise visual mode, but better
Plug 'Raimondi/delimitMate'            " Delimiter auto-matching
Plug 'takac/vim-hardtime'              " Stop spamming hjkl!
Plug 'bronson/vim-trailing-whitespace' " Show trailing whitespace
Plug 'ervandew/supertab'               " Autocomplete
Plug 'tpope/vim-endwise', { 'for': 'ruby' } " Auto complete 'end' keywords
Plug 'junegunn/vim-easy-align'         " Align stuff (easily)
" Web Functionality -------------------------------------------------------
Plug 'mattn/webapi-vim'              " Dependency for gist-vim
Plug 'mattn/gist-vim'                " Post buffer/selection to Gist
Plug 'joshhartigan/vim-reddit'       " Browse reddit in Vim
" Language Support --------------------------------------------------------
Plug 'sheerun/vim-polyglot'          " Lots of languages
Plug 'justinmk/vim-syntax-extra'     " Better for C
" Other functionality -----------------------------------------------------
Plug 'mhinz/vim-random'              " Jump to random help tags for learning
Plug 'esneider/YUNOcommit.vim'       " Y U NO Comment after so many writes?
Plug 'loremipsum'                    " Insertion of dummy text
Plug 'kien/ctrlp.vim'                " Fuzzy file finder
Plug 'jez/vim-superman'              " Read unix man pages in Vim
" -------------------------------------------------------------------------

" All plugins must be inserted before this line
call plug#end()

" Plugin options can go after this point

let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1

" No delimitMate for clojure or HTML
au BufRead *.clj DelimitMateOff
au BufRead *.html DelimitMateOff

" Better mode for the molokai color scheme
let g:rehash256 = 1

" Autocomplete, always
let g:neocomplete#enable_at_startup = 1

" Speed up CtrlP
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

if melonEmoji && !has('gui_running')
  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'component': {
        \   'readonly': '%{&readonly?"":"🍉  "}'
        \ }
  \ }
else
  let g:lightline = { 'colorscheme': 'solarized' }
endif

" Start interactive easyalign in visual mode
vmap <enter> <plug>(EasyAlign)

" Start interactive easyalign for a motion/object
nmap ga <plug>(EasyAlign)

" }}}

"0a272fef24 || moving around, searching, and patterns {{{

" Better home/end keys - synonymous to normal movement
nnoremap H ^
nnoremap L $
vnoremap L $

" Move up and down a bit faster
func! Scroll(dir, distance)
  let curline = &cursorline
  set nocursorline

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

  let &cursorline = curline
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
inoremap <up>    <esc>ddkPi
inoremap <down>  <esc>ddpi

nnoremap <right> <esc>>>
nnoremap <left>  <esc><<
nnoremap <up>    <esc>ddkP
nnoremap <down>  <esc>ddp

" I have another mapping for this but who cares
vnoremap <right> >gv
vnoremap <left>  <gv

" This allows one less keypress for going to line X
" e.g. 151\ will take me to line 151.
nnoremap \ G

" }}}

"e1150751ea || syntax, highlighting and spelling {{{

" Turn syntax colouring on
syntax enable

" 256 colors enabled in terminal
set t_Co=256

" My color scheme changes so much that it isn't worth
" updating the vimrc file and commiting to GitHub just
" for a small change.
source ~/.vimcolor

if 0
  " (press <leader>S on the next line to edit this file)
  sp ~/.vimcolor
endif

if g:colors_name == 'default'
  if &number
    " line numbers
    hi LineNr ctermbg=8
  endif
  " braces, parens, commas, etc
  hi Noise ctermfg=8
  " some keywords
  hi Type      cterm=bold
  hi Statement cterm=bold
endif

" More subdued ~ characters on blank lines
if &background == 'light'
  hi NonText ctermfg=7 cterm=NONE
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" Concealing stuff
set conceallevel=2 " enable
hi Conceal ctermfg=5 ctermbg=0

func! HighlightCurrentWord()
  let word = expand("<cword>")
  execute ':syn match Type /' . word . '/'
endfunc
nnoremap <leader>' :call HighlightCurrentWord()<cr>

" }}}

"6ba63c409e || abbreviations {{{

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

iabbrev psvm public static void main(String args[]) {<cr>

" }}}

"1ec442eb14 || keybindings {{{

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
nnoremap <leader>b :w<cr>

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

" Insert line between braces / parentheses
if (&ft != 'clojure')
  inoremap {<cr> {<cr>}<c-o>O
  inoremap (<cr> (<cr>)<c-o>O
  inoremap ({<cr> ({<cr>})<c-o>O
 endif

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

" Switch between buffers
nnoremap <backspace> :bnext<cr>

" Quick `make` calling - no output.
nnoremap <leader>m :silent make\|redraw!\|cc<CR>

" Leave terminal mode
if has('nvim')
  tnoremap <esc> <c-\><c-n>gg
endif

" }}}

"78ceb12190 || interface {{{

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

  set guifont=Monaco:h14

  " Use italics for certain words
  highlight Comment gui=italic
  highlight Identifier gui=italic,bold
  highlight Constant gui=italic

  " Highlight Markdown / HTML as it should be
  highlight htmlItalic gui=italic
  highlight htmlBold gui=bold

  " Minimalise gvim/macvim interface
  " set guioptions+=c " Use console dialogs instead of popups for choices
  " set guioptions-=m " Hide menu bar
  " set guioptions-=r " Never show vertical scrollbar
  " set guioptions-=b " Never show horizontal scrollbar
  " set guioptions-=T " Hide ugliest toolbar ever
  " set guioptions-=R " Don't show right scrollbar with vsplits
  " set guioptions-=L " Don't show left scrollbar with vsplits
  " set guioptions-=e " Use non-gui tabs

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

" Underline search matches rather than highlighting them.
" Undercurl is rarely available, but if it isn't, it just
" subsitutes for underline :)
highlight Search ctermbg=black ctermfg=brown cterm=undercurl

" Don't highlight matching braces, underline them
highlight MatchParen cterm=underline ctermbg=bg guibg=bg

" }}}

"c1b2b7a346 || text and file formatting and folds {{{

" Use foldmarker folding method (three braces to open and close)
set foldmethod=syntax
set foldlevelstart=100 " keep all folds open by default

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

" }}}

"d65afaadb4 || backups {{{

set undodir=~/.vim/undo      " Undo-change files

set nobackup                 " Disable backups
set writebackup              " Make backup before overwriting, until save

set noswapfile               " I hate swap files; they must burn

" }}}

"90aca44b20 || filetype specific {{{

" Usually .txt or .md is for documentation / info, in which
" case I will want spellchecking on.
if useSpellCheck
  au WinEnter *.{md,txt} set spell
  au WinLeave *.{md,txt} set nospell
endif

" Auto golang formatting
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Hooray for EcmaScript 6
au BufRead,BufWrite *.es6 setf javascript

" Stylistic JavaScript
syntax keyword jsThis this conceal cchar=@

" 'puts' is used for debugging a lot, so I make it more visible.
au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

" I use the string and vector types often in c++, and I like colours
au BufEnter *.{cc,cpp,cxx} syn match Type /string/
au BufEnter *.{cc,cpp,cxx} syn match Type /vector/

" I use this as a typedef in C
au BufEnter *.c syn match Type /String/

" Convert markdown link to HTML link (anywhere in line)
nnoremap <leader>ml F[i<a href=""><esc>f[xf]xi</a><esc>ldi(2F"pf(xx

" I don't use modula2, but I do use markdown.
au BufNewFile,BufRead,BufWrite *.md set filetype=markdown
" Syntax highlighting for markdown code blocks
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

au BufEnter *.css inoremap : :;<esc>i
au BufEnter *.css inoremap ; <esc>la
au BufLeave *.css iunmap :
au BufLeave *.css iunmap ;

" }}}

"c2b048731a || quick-open files {{{

" Open ~/.vimrc in same buffer
nnoremap <leader>ev :e $VIMRC<cr>

" Open ~/.bashrc in same buffer
nnoremap <leader>eb :e ~/.bashrc<cr>

nnoremap <leader>ep :cd $PROJECTS/

" Open .vimrc in split
nnoremap <leader>v :sp $VIMRC<cr>

" }}}

"c938316bde || functions and misc {{{

func! s:millisecs_since(time)
  let cost = split(reltimestr(reltime(a:time)), '\.')
  return str2nr(cost[0]) * 1000 + str2nr(cost[1]) / 1000.0
endfunc

" }}}
