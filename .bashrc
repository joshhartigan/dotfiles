export PATH=/usr/local/bin:~/bin:$PATH

export PS1="\[\e[01;30m\]\u\[\e[0m\]\[\e[00;30m\]/\W\[\e[0m\]\[\e[01;30m\]\\$\[\e[0m\] "

shopt -s nocaseglob # case insensitive filename expansion
shopt -s cdspell    # autocorrect filename typos in `cd`
alias ls='ls -G'    # use ls with color by default
alias npi='sudo npm install -g' # faster npm installation
alias clj='java -cp /usr/local/jars/clojure.jar clojure.main'
alias hack='cat /dev/random | hexdump'

# pastebin from ptpb.pw
pb() {
  echo $1 | curl -F c=@- https://ptpb.pw
}

# better bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
