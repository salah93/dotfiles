
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# command line interface
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# environment variables
# PS1
export PS1="\u@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\]$ "
#"]]]"

# Directories
export PROJECTS=~/Projects
export EXPERIMENTS=~/Experiments
export WORKON_HOME=~/.virtualenvs
export TEMPLATES=${HOME}/Templates

export VISUAL=vim
export EDITOR=$VISUAL

# Scala
export SCALA_HOME=/usr/local/share/scala-2.12.7

# PATH
PATH=${PATH}:$SCALA_HOME/bin
PATH=${PATH}:/usr/local/lib/node-v10.13.0-linux-x64/bin
export PATH=$PATH:$HOME/.local/bin:$HOME/.scripts/


# virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=`which python3`
source /usr/local/bin/virtualenvwrapper.sh

mkdir -p ${PROJECTS}
mkdir -p ${EXPERIMENTS}
