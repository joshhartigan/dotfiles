export TERM=xterm-256color # This is required for emacs (ansi-term)

# Certain things should only be run if I am on OS X,
# So I have created a file especially for them.
if [ "$(uname)" == "Darwin" ]; then
  . $HOME/.osx
fi

# I put /usr/local/bin and $USER/bin before
# the rest of my $PATH, so that custom replacements
# of default programs will override the things
# they're replacing.
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:$PATH

export PS1="\[\e[00;36m\]\w\[\e[0m\]\[\e[00;31m\]: \[\e[0m\]"

export EDITOR="vim"
export VIMRC="$HOME/.vimrc"
export BASHRC="$HOME/.bashrc"

# The projects folder is where I keep miscellaneous
# programming things, like Git repos.
export PROJECTS="/Users/josh/projects"

shopt -s nocaseglob # Case insensitive filename expansion
shopt -s cdspell    # Autocorrect filename typos in `cd`

alias npi='sudo npm install -g' # Faster npm installation

alias py='python'
alias rb='ruby'

alias ls='ls -tG' # Use ls with color by default (and order by date)
alias grep='egrep -i --colour=always' # Better regex, colour, insensitive.
alias cp='cp -iv' # Interactive and verbose `cp`
alias mv='mv -iv' # Interactive and verbose `mv`
alias mkdir='mkdir -p' # Create intermediate directories

alias ll='ls -FGlAhp' # Super verbose `ls`
alias up='cd ..'

export GREP_COLOR="00;31"
export LSCOLORS=DxFxExBxCxegedabagacad

project() { cd $PROJECTS/$1; }

# `cl()` is another way of navigating folders.
# It enters the directory, then lists all of the
# files inside the directory.
# `cll()` is a more verbose form of `cl()`.
cl()  { cd $1 && ls; }
cll() { cd $1 && ll; }


# Make it look like you're doing 'hacking' from a
# Hollywood film.
alias hack='cat /dev/random | hexdump'

# Rust is a cool language but it's very unstable,
# so this command must be run often to update it.
alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'

# I have got aliases for some long but very common
# Git commands.
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'

# This is a lifesaver for getting projects
# GitHub quickly. Example:
# `$ get joshhartigan/dotfiles`
get() { git clone https://github.com/$1; }

raw() {
  if [ ! -d .git ]; then
    echo "you're not in the root of a git repository!"
    return
  fi

  remote_url=`git config --get remote.origin.url | \
              sed 's/https:\/\/github\.com//'`
  branch_name=`git branch | grep '\*' | sed 's/\* //'`

  if hash xdg-open 2>/dev/null; then
    xdg-open https://raw.githubusercontent.com$remote_url/$branch_name/$1
  elif hash open 2>/dev/null; then
    open https://raw.githubusercontent.com$remote_url/$branch_name/$1
  else
    echo https://raw.githubusercontent.com$remote_url/$branch_name/$1
  fi
}

# This will paste things onto ptpb.pw
pb() {
  echo $1 | curl -F c=@- https://ptpb.pw
}

# This will update my GitHub .vimrc to the one that
# I have on my computer.
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

# read man pages in vim
vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

alias man=vman

# use C like a scripting language
crun() {
  gcc $1.c
  $2 # any extra arguments if they're supplied
  -o $1
  ./$1
  rm $1
}

# Enable better completion for npm
. <(npm completion)

export NVM_DIR="/Users/josh/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
