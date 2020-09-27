# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# command line interface
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_tf_workspace() {
    if [[ -e .terraform ]]
    then
        if hash terraform 2>/dev/null
        then
            terraform workspace show 2> /dev/null | sed -e 's/\(.*\)/(\1) /'
        fi
    fi
}

find_git_dirty() {
  local status=$(git status --untracked=no --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    echo '***'
  else
    echo ''
  fi
}

# PS1
# \[  \] - start/stop command
# \e[ start color scheme
# m stop color scheme
# 0;xx  color scheme (Dark)
# 1;xx  color scheme (light)
#
#    Normal Text: 0
#    Bold or Light Text: 1 (It depends on the terminal emulator.)
#    Dim Text: 2
#    Underlined Text: 4
#    Blinking Text: 5 (This does not work in most terminal emulators.)
#    Reversed Text: 7 (This inverts the foreground and background colors, so you’ll see black text on a white background if the current text is white text on a black background.)
#    Hidden Text: 8

export PS1="\[\e[2;33m\]\$(parse_tf_workspace)\[\e[2;00m\]\u\[\e[2;35m\]@\[\e[2;00m\]resy \[\e[2;32m\]\W \[\e[2;33m\]\$(parse_git_branch)\[\e[2;31m\]\$(find_git_dirty)\[\e[2;00m\]\$ "

# aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lFG'
alias la='ls -A'
alias l='ls -CF'
alias ct='/usr/local/bin/ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags ./'
alias gt='git commit --allow-empty -m  "trigger"'
alias gs='git status'
alias gd='git diff'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ 0 = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

export WORKON_HOME=$HOME/.virtualenvs

# functions
v() {
    . ${WORKON_HOME}/env/bin/activate;
}

i() {
    ipython $@;
}

b() {
    bpython -i ~/.config/bpython/auto_import.py
}

vm() {
    vim --noplugin $@
}

vf() {
    vim `fzf`
}

py() {
    python3.5 $@;
}

n() {
    jupyter notebook;
}

mkapp(){
   cookiecutter gh:salah93/cookiecutter-python-project
}

whatis() {
    curl cht.sh/$1
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
  elif [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
  fi
fi

## search history arrow up
bind '"\e[A": history-search-backward'
## search history arrow down
bind '"\e[B": history-search-forward'


# direnv
eval "$(direnv hook bash)"
source <(doctl completion bash)
