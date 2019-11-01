PATH=${PATH}:$SCALA_HOME/bin
PATH=${PATH}:/usr/local/lib/node-v10.13.0-linux-x64/bin
PATH=${PATH}:/usr/local/share/applications/charles-proxy-4.2.8_amd64/charles/bin
PATH=$PATH:$HOME/.local/bin:$HOME/.scripts/
export PATH="$HOME/.poetry/bin:$PATH"
export TERM=xterm-256color

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export GPG_TTY=$(tty)
