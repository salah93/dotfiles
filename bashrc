# echo "bashrc executed"
# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Define environment variables
# Directories
export PROJECTS=~/Projects
export WORKON_HOME=~/.virtualenvs
export TEMPLATES=${HOME}/Templates

export VISUAL=vim
export EDITOR=$VISUAL

mkdir -p ${PROJECTS}

# Scala
export SCALA_HOME=/usr/local/share/scala-2.12.7

# PATH
PATH=${PATH}:$SCALA_HOME/bin
PATH=${PATH}:/usr/local/lib/node-v10.13.0-linux-x64/bin
export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts/

# Add aliases

alias ls='ls --color'
alias ct='ctags -R --fields=+l --languages=python --python-kinds=-iv -f /.tags ./'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ 0 = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# functions
git-grep() {
    string=$1
    if [ $# -eq 1 ]; then
        echo here
        git grep $string $(git rev-list --all)
    else
        shift
        git grep $string $@
    fi
}

v() {
    . ${WORKON_HOME}/env/bin/activate;
}

i() {
    ipython;
}

n() {
    jupyter lab;
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

# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=`which python3`
source /usr/local/bin/virtualenvwrapper.sh

# command line interface
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
#"]]]"

whatis() {
    curl cht.sh/$1
}


## search history arrow up
bind '"\e[A": history-search-backward'
## search history arrow down
bind '"\e[B": history-search-forward'
