export TERM=xterm

# I put /usr/local/bin and ~/bin before the rest of  #
# my $PATH. This is so that custom replacements of   #
# default programs that are shipped with the OS can  #
# override the default programs.                     #
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

# My bash prompt looks like this:                    #
# "josh/directory$ "                                 #
# it is also colourful.                              #
export PS1="\[\e[00;34m\]\u\[\e[0m\]\[\e[00;37m\]/\[\e[0m\]\[\e[00;36m\]\W\[\e[0m\]\[\e[00;34m\]\\$\[\e[0m\]\[\e[00;37m\] \[\e[0m\]"

export EDITOR="vim"
export VIMRC="$HOME/.vimrc"
export BASHRC="$HOME/.bashrc"

export PROJECTS="~/Projects"
