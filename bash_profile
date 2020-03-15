# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Directories
export VISUAL=vim
export EDITOR=$VISUAL

# ls colors
export LSCOLORS='gxfxcxdxbxegedabagacad'
export TERM=xterm-256color

# Scala
export SCALA_HOME=/usr/local/share/scala-2.12.7

# PATH
PATH=$SCALA_HOME/bin:$PATH
PATH=/usr/local/lib/node-v10.13.0-linux-x64/bin:$PATH
PATH=/usr/local/share/applications/charles-proxy-4.2.8_amd64/charles/bin:$PATH
PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.scripts:$PATH

#LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib
