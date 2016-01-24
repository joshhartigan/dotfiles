GOPATH=$HOME/programs/lang/go
JSPATH=$HOME/programs/lang/javascript
CPATH=$HOME/programs/lang/c
PYPATH=$HOME/programs/lang/python/

# add user-created executables to PATH
export PATH=$PATH:$GOPATH/bin:$JSPATH/bin:$CPATH/bin:$PYPATH/bin

# add npm-installed executables to PATH
export PATH=$PATH:$HOME/.node/bin

shopt -s nocaseglob # ignore case in autocomplete
shopt -s cdspell # autocorrection in `cd` arguments

# magenta directories
# green symlinks
# bold cyan executables
export LSCOLORS=fxcxcxcxGxcxGxGxexex
alias ls='gls --color --group-directories-first'

# shortcut to reopen last file in vim
alias v="vim -c \"normal '0\""

alias vim="mvim"

# shortcut for editing files in the
# c programming directory
edit() {
  if [ -d "./code" ]; then
    vim code/$1.c
  fi
}

# programming language shortcuts
alias py='python'
alias rb='ruby'
alias js='node'

if [ -x /usr/local/Cellar/gcc/5.2.0/bin/gcc-5 ]; then
  alias gcc='/usr/local/Cellar/gcc/5.2.0/bin/gcc-5'
fi

# utliity shortcuts
alias up='cd ..'
alias cp='cp -iv' # interactive and verbose `cp`
alias mv='mv -iv' # interactive and verbose `mv`
alias mkdir='mkdir -p' # create intermediate directories
alias grep='egrep -i --colour=always' # -i = insensitive.
                                        # -H = show filename
                                        # -n = show line number
alias GREP='egrep -Hn --colour=always'

alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
get() { git clone https://github.com/$1; }
getmy() { git clone https://github.com/joshhartigan/$1; }

# document writing
mdpdf() { pandoc $1 --latex-engine=xelatex -o $2; }

export PS1="\[\033[38;5;7m\]\w\[$(tput sgr0)\] "
