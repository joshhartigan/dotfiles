export TERM=xterm # This is required for emacs (ansi-term)
                                                     #
# I put /usr/local/bin and $USER/bin before          #
# the rest of my $PATH, so that custom replacements  #
# of default programs will override the things       #
# they're replacing.                                 #
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
                                                     #
# My bash prompt looks like this:                    #
# "josh/directory$ "                                 #
# It is colourful.                                   #
export PS1="\[\e[00;34m\]\u\[\e[0m\]\[\e[00;37m\]/\[\e[0m\]\[\e[00;36m\]\W\[\e[0m\]\[\e[00;34m\]\\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"
                                                     #
export EDITOR="vim"
export VIMRC="$HOME/.vimrc"                          #
export BASHRC="$HOME/.bashrc"                        #
                                                     #
# The projects folder is where I keep miscellaneous  #
# programming things, like Git repos.                #
export PROJECTS="~/Projects"

# Who cares about 'editor wars'.                     #
# I use both for different things and they're good.  #
alias vim='nvim'    # Vim is dead; Long live NeoVim.
alias em='open /usr/local/Cellar/emacs/24.4/Emacs.app/ &'

shopt -s nocaseglob # Case insensitive filename expansion
shopt -s cdspell    # Autocorrect filename typos in `cd`

alias npi='sudo npm install -g' # Faster npm installation

alias ls='ls -G' # Use ls with color by default
alias grep='egrep --colour=always' # Show grep matches. Use better regexes.
alias cp='cp -iv' # Interactive and verbose `cp`
alias mv='mv -iv' # Interactive and verbose `mv`
alias mkdir='mkdir -p' # Create intermediate directories

alias ll='ls -FGlAhp' # Super verbose `ls`
alias up='cd ..'

export GREP_COLOR="00;31"
export LSCOLORS=DxFxExBxCxegedabagacad

project() { cd $PROJECTS/$1; }

# `cl()` is another way of navigating folders.      #
# It enters the directory, then lists all of the    #
# files inside the directory.                       #
cl() { cd $1 && ls; }

# I don't often use Clojure, but this is how I do.  #
# I don't use Leiningen because it is buggy to      #
# install on OS X and I don't want to fix it.       #
alias clj='java -cp /usr/local/jars/clojure.jar clojure.main'

# Make it look like you're doing 'hacking' from a   #
# Hollywood film.                                   #
alias hack='cat /dev/random | hexdump'

# Rust is a cool language but it's very unstable,   #
# so this command must be run often to update it.   #
alias rustup='curl -s https://static.rust-lang.org/rustup.sh | sh'

# I have got aliases for some long but very common  #
# Git commands.                                     #
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'

# This is a lifesaver for getting projects off of   #
# GitHub quickly. Example:                          #
# `$ get joshhartigan/dotfiles`                     #
get() { git clone https://github.com/$1; }

raw() {
  if [ ! -d .git ]; then
    echo "you're not in the root of a git repository!"
    return
  fi

  remote_url=`git config --get remote.origin.url | \
              sed 's/https:\/\/github\.com//'`
  branch_name=`git branch | grep '*' | sed 's/\* //'`

  if hash xdg-open 2>/dev/null; then
    xdg-open https://raw.githubusercontent.com$remote_url/$branch_name/$1
  elif hash open 2>/dev/null; then
    open https://raw.githubusercontent.com$remote_url/$branch_name/$1
  else
    echo https://raw.githubusercontent.com$remote_url/$branch_name/$1
  fi
}

# This will paste things onto ptpb.pw               #
pb() {
  echo $1 | curl -F c=@- https://ptpb.pw
}

# Better bash completion for certain programs,      #
# provided by brew package manager.                 #
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
