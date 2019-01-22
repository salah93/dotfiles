
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

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
