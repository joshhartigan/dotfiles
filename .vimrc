" basic options                                          {{{

let $VIMRC = "~/.vimrc"

set encoding=utf-8         " what are you, stupid?
set autoindent             " copy indent from current line onto next
set smartindent            " better indentaion with C-like (i.e. { }) languages
set hidden                 " hide buffer when it is abandoned
set ttyfast                " imporove redrawing smoothness
set backspace=indent,eol,start " allow backspacing over indent, eol, sol
set nonumber               " don't show line numbers
set laststatus=2           " always show status line
set history=1000           " remember 1000 ':' commands
set showbreak=↪            " show this character on folded lines
set matchtime=3            " highlight parentheses for 30 1/10s of a secon
set splitright             " vertically split windows onto the right side
set title                  " set window name to 'titlestring' or default
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

if has("breakindent")
  set breakindent          " continue indentation on wrapped lines (v7.4.338+)
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

" }}}

" vim-plug / plugins                                     {{{

call plug#begin('~/.vim/plugged')
  Plug 'ervandew/supertab'             " Word autocompletion with <tab>
  Plug 'molok/vim-smartusline'         " Super simple status line
  Plug 'hail2u/vim-css3-syntax'        " Better CSS syntax highlighting
  Plug 'tpope/vim-surround'            " Surround text objects with characters
  Plug 'camelcasemotion'               " Text objects for CamelCase words
  Plug 'mhinz/vim-random'              " Jump to random help tags for learning
  Plug 'justinmk/vim-sneak'            " Motion - goto next s[char][char]
  Plug 'esneider/YUNOcommit.vim'       " Y U NO Comment after so many writes?
  Plug 'ap/vim-css-color'              " Show CSS colors in their color
  Plug 'joshhartigan/SimpleCommenter'  " Comment out lines simply
  Plug 'wting/rust.vim'                " Rust support for Vim
  Plug 'kana/vim-niceblock'            " Blockwise visual mode, but better
  Plug 'itchyny/vim-highlighturl'      " URL highlight everywhere
  Plug 'pangloss/vim-javascript'       " Better JavaScript syntax highlighting
  Plug 'mhinz/vim-startify'            " A fancy start screen for Vim
call plug#end()

" }}}

" moving around, searching, and patterns                 {{{

" Better home/end keys - synonymous to normal movement
nnoremap H ^
nnoremap L $
vnoremap L $

" Move up and down a bit faster
nnoremap N 9j
vnoremap N 9j
nnoremap M 9k
vnoremap M 9k

" Emacs-like Home/End in insert and command mode
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Keep the current line in the center
set scrolloff=1000

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
nnoremap <leader><cr> :nohlsearch<cr>

" Move between splits with w + hjkl, new splits with ws or wv
" 'w' stands for 'window'
nnoremap w <c-w>

" }}}

" syntax, highlighting and spelling                      {{{

" Turn syntax colouring on
syntax enable

" 256 colors enabled in terminal
set t_Co=256

if filereadable( expand("~/.vim/colors/garden.vim") )
  set background=dark
  color garden
endif

if has("gui_running")
  " Slightly customised highlighting - more subtle line numbers
  highlight LineNr guibg=bg guifg=#333333
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" }}}

" abbreviations                                          {{{

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

" }}}

" keybindings                                            {{{

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
noremap Q <Nop>
nnoremap <leader>Q :q!<cr>

" Save file quickly
nnoremap b :w<cr>

" Use , rather than ; for repeating f/t/F/T motions
nnoremap , ;

" Prevent hours of time / megajoules of energy
nnoremap ; :
vnoremap ; :

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

" Sublime-esque indentation in visual mode ([un]indent; reselect)
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Insert line between braces / parentheses
inoremap {<cr> {<cr>}<c-o>O
inoremap (<cr> (<cr>)<c-o>O

" Reload .vimrc on command
nnoremap <leader>u :source $VIMRC<cr>

" Soure current line / selection
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Show current highlight group/s - very useful for creating modifications
" to syntax highlighting.
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" % is too far away
nnoremap ) %

" alt-h to hide search-match highlighting
nnoremap ˙ :noh<cr>

" }}}

" interface                                              {{{

" Set the status line to a sensible default for smartusline
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Better looking splits
set fillchars+=vert:\
highlight VertSplit ctermfg=0 ctermbg=0

" Cursorline only in current window, only in normal mode (Steve Losh)
"augroup cline
"au!
"au WinLeave,InsertEnter * set nocursorline
"au WinEnter,InsertLeave * set cursorline
"augroup END

" More stand-out cursor (it's orange!)
highlight Cursor guibg=#FEC52E

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

endif

set linespace=2 " Put 2 pixels in between each line of text

" }}}

" text and file formatting and folds                     {{{

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

" }}}

" backups                                                {{{

set undodir=~/.vim/undo      " Undo-change files

set nobackup                 " Disable backups
set writebackup              " Make backup before overwriting, until save

set noswapfile               " I hate swap files; they must burn

" }}}

" filetype specific                                      {{{

" Usually .txt or .md is for documentation / info, in which
" case I will want spellchecking on.
au WinEnter *.{md,txt} set spell
au WinLeave *.{md,txt} set nospell

" Auto golang formatting
autocmd FileType go autocmd BufWritePre <buffer> Fmt
" ... not that I use Go anymore. It sucks.

" 'puts' is used for debugging a lot, so I make it more visible.
au BufEnter *.rb syn match Function 'puts'
au BufEnter *.rb syn match Function 'print'

" I use the string and vector types often in c++, and I like colours
au BufWrite *.{cc,cpp,cxx} syn match Type /string/
au BufWrite *.{cc,cpp,cxx} syn match Type /vector/

" Convert markdown link to HTML link (anywhere in line)
nnoremap <leader>ml F[i<a href=""><esc>f[xf]xi</a><esc>ldi(2F"pf(xx

" I don't use modula2, but I do use markdown.
au BufNewFile,BufRead,BufWrite *.md set filetype=markdown

" }}}

" quick-open files                                       {{{

" Open ~/.vimrc in same buffer
nnoremap <leader>ev :e $VIMRC<cr>

" Open ~/.bashrc in same buffer
nnoremap <leader>eb :e ~/.bashrc<cr>

nnoremap <leader>ep :cd $PROJECTS/

" Open .vimrc in split
nnoremap <leader>v :sp $VIMRC<cr>

" }}}

" show indentation depth                                 {{{

nn <silent> <leader>B :call BlockColor(8, 0x101010)<cr>

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

