GOPATH=$HOME/programs/lang/go
JSPATH=$HOME/programs/lang/javascript
CPATH=$HOME/programs/lang/c
PYPATH=$HOME/programs/lang/python

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
alias ls='ls | wc -l && gls -p --color --group-directories-first'

# neovim
alias vim='nvim'

# shortcut to reopen last file in vim
alias v="vim -c \"normal '0\""

alias site="cd ~/programs/webpages/site"

# programming language shortcuts
alias py='python'
alias rb='ruby'
alias js='node'

# use homebrew-installed gcc
if [ -x /usr/local/Cellar/gcc/5.2.0/bin/gcc-5 ]; then
  alias gcc='/usr/local/Cellar/gcc/5.2.0/bin/gcc-5'
fi

# utliity shortcuts
alias up='cd ..'
alias cp='cp -iv' # interactive and verbose `cp`
alias mv='mv -iv' # interactive and verbose `mv`
alias mkdir='mkdir -p' # create intermediate directories
alias grep='egrep -i --colour=always'  # -i = insensitive.
alias GREP='egrep -Hn --colour=always' # -H = show filename, -n = show line number
cl() { cd $1 && ls; }

# to update rust (which I don't use)
alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
get() { git clone https://github.com/$1; }
getmy() { git clone https://github.com/joshhartigan/$1; }

# markdown to pdf
mdpdf() { pandoc $1 --latex-engine=xelatex -o $2; }

# download all images from a 4chan thread
chand() { wget -qe robots=off -rHDi.4cdn.org -nc -nd -ERs.jpg,html $1; }

# choose a random word of a given regex
rdwd() {
  grep $1 /usr/share/dict/words | sed "$(jot -r 1 1 $(grep $1 /usr/share/dict/words | wc -l))q;d"
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PS1="\[\e[33;40m\]\W\[\e[m\] \[\e[36m\]*\[\e[m\] "

# required for base16 colour schemes
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
