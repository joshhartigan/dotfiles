export GOPATH=$HOME/programs/go
export PATH=$PATH:$GOPATH/bin

shopt -s nocaseglob # Case insensitive filename expansion
shopt -s cdspell    # Autocorrect filename typos in `cd`

alias py='python'
alias rb='ruby'

alias ls='ls -tG' # Use ls with color by default (and order by date)
alias grep='egrep -i --colour=always' # Better regex, colour, insensitive.
alias cp='cp -iv' # Interactive and verbose `cp`
alias mv='mv -iv' # Interactive and verbose `mv`
alias mkdir='mkdir -p' # Create intermediate directories

alias up='cd ..'

export GREP_COLOR="00;31"
export LSCOLORS=DxFxExBxCxegedabagacad

alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'

alias gpom='git push origin master'
alias gpog='git push origin gh-pages'

get() { git clone https://github.com/$1; }
getmy() { git clone https://github.com/joshhartigan/$1; }

updateVimRC() {
  git clone https://github.com/joshhartigan/dotfiles
  cd dotfiles
  cp ../.vimrc .
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
  cp ../.bashrc .
  git add .bashrc
  read -e -p 'commit message: ' commitMsg
  git co -m "$commitMsg"
  git push origin master
  cd ..
  rm -rf dotfiles
}

export PS1="    \[\e[00;34m\]\w\[\e[0m\]\[\e[00;36m\]\\$ \[\e[0m\]"
