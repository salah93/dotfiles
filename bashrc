# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# virtualenvwrapper
#export VIRTUALENVWRAPPER_PYTHON=`which python3`
#source /usr/local/bin/virtualenvwrapper.sh

# command line interface
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
#"]]]"

# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias ct='ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags ./'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ 0 = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# functions
v() {
    . ${WORKON_HOME}/env/bin/activate;
}

i() {
    ipython3 $@;
}

py() {
    python3 $@;
}

n() {
    jupyter notebook;
}

# templates
mkhtml() {
    cp $TEMPLATES/index.html $1
}

mkfl(){
    cp -n $TEMPLATES/flask.py $1
}

mkmodels(){
    cp -n $TEMPLATES/models.py $1
}

mkapp(){
    cp -n $TEMPLATES/app.py $1
}

whatis() {
    curl cht.sh/$1
}

bd() {
    case $RESY_ENV in
    "api")
       connection="local"
       ;;
    "inventory")
        connection="inventory"
        ;;
    "menu")
        connection="menu"
        ;;
    *)
        connection="local"
        ;;
    esac
    build_rdbms ${connection} --all
}

gb() {
    grep- -i --include "build.py" $@
}

# History
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make 'less' more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

## search history arrow up
bind '"\e[A": history-search-backward'
## search history arrow down
bind '"\e[B": history-search-forward'
