# environment
set -x VISUAL vim
set -x EDITOR $VISUAL
set -x GPG_TTY (tty)
## ls colors
set -x LSCOLORS 'gxfxcxdxbxegedabagacad'
set -x TERM xterm-256color
## PATH
set -x PATH $PATH $HOME/.local/bin $HOME/.scripts $HOME/.docker-scripts

function parse_git_branch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
end

function parse_tf_workspace
    if test -e .terraform
        if hash terraform 2>/dev/null
            terraform workspace show 2> /dev/null | sed -e 's/\(.*\)/(\1) /'
        end
    end
end

function find_git_dirty
  set -l _git_status (git status --untracked=no --porcelain 2> /dev/null)
  if test "$_git_status" != "" 
    echo '***'
  else
    echo ''
  end
end

function v
    source ~/.virtualenvs/env/bin/activate.fish
end

function whatis
    curl cht.sh/$argv[1]
end

function mkapp
    cookiecutter gh:salah93/cookiecutter-python-project
end

alias ct='/usr/local/bin/ctags -R --fields=+l --languages=python --python-kinds=-iv -f ./tags ./'
alias gt='git commit --allow-empty -m  "trigger"'
alias gs='git status'
alias gd='git diff'
bind -k up history-search-backward

# pyenv
pyenv init - | source

# direnv
eval (direnv hook fish)

# iTerm2 integration
[ -e ~/.iterm2_shell_integration.fish ]; and source ~/.iterm2_shell_integration.fish
