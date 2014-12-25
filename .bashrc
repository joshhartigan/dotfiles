# i put /usr/local/bin and $USER/bin before
# the rest of my $PATH, so that custom replacements
# of default programs will override the things
# they're replacing
export PATH=/usr/local/bin:~/bin:$PATH

# my prompt is very simple and works with every color scheme:
yellow="\[\e[00;33m\]"
dir_basename="\W"
default_color="\[\e[0m\]"
export PS1="$yellow$dir_basename \$ $default_color"

export EDITOR="vim"

shopt -s nocaseglob # case insensitive filename expansion
shopt -s cdspell    # autocorrect filename typos in `cd`
alias ls='ls -G'    # use ls with color by default
alias npi='sudo npm install -g' # faster npm installation

# i don't often use clojure, and so I don't use leiningen.
# also, leiningen is very buggy on OS X and i don't want to fix it
alias clj='java -cp /usr/local/jars/clojure.jar clojure.main'

# this looks funny
alias hack='cat /dev/random | hexdump'

# rust is a cool language but it's very unstable, so this command
# must be run often
alias rustupdate='curl -s https://static.rust-lang.org/rustup.sh | sh'

# pastebin from ptpb.pw
pb() {
  echo $1 | curl -F c=@- https://ptpb.pw
}

# better bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
