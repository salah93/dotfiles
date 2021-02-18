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

# PATH
PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.scripts:$PATH
export PATH=$PATH:/usr/local/go/bin
export GPG_TTY=$(tty)
source "$HOME/.cargo/env"

# >>> coursier install directory >>>
export PATH="$PATH:/home/salah/.local/share/coursier/bin"
# <<< coursier install directory <<<
