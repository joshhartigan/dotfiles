export GOPATH=$HOME/programs/go
export PATH=$PATH:$GOPATH/bin
export JSPATH=$HOME/programs/javascript
export PATH=$PATH:$JSPATH/bin
export CPATH=$HOME/programs/c
export PATH=$PATH:$CPATH/bin
export PATH=$PATH:$HOME/.node/bin
export PATH="/usr/local/sbin:$PATH"

shopt -s nocaseglob
shopt -s cdspell

export GREP_COLOR="00;31"

alias py='python'
alias rb='ruby'
alias js='node'
alias cc='gcc'
alias up='cd ..'
alias ls='gls --color --group-directories-first' # `man ls` for explanation.
alias grep='egrep -i --colour=always' # Better regex, colour, insensitive.
alias cp='cp -iv' # interactive and verbose `cp`
alias mv='mv -iv' # interactive and verbose `mv`
alias mkdir='mkdir -p' # create intermediate directories
alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'
alias git='hub'
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'

alias gcc=/usr/local/Cellar/gcc/5.2.0/bin/gcc-5
alias g++=/usr/local/Cellar/gcc/5.2.0/bin/g++-5

get() { git clone https://github.com/$1; }
getmy() { git clone https://github.com/joshhartigan/$1; }

updateVimRC() {
  git clone https://github.com/joshhartigan/dotfiles
  cd dotfiles
  cp ~/.vimrc .
  git add .vimrc
  read -e -p 'commit message: ' commitMsg
  git co -m "$commitMsg"
  git push origin master
  cd ..
  rm -rf dotfiles
}

updateBashRC() {
  git clone https://github.com/joshhartigan/dotfiles
  cd dotfiles
  cp ~/.bashrc .
  git add .bashrc
  read -e -p 'commit message: ' commitMsg
  git co -m "$commitMsg"
  git push origin master
  cd ..
  rm -rf dotfiles
}

export PS1="\[$(tput bold)\]\w ❯\[$(tput sgr0)\] "
