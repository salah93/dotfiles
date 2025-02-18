# environment
set -x VISUAL vim
set -x EDITOR $VISUAL
set -x GPG_TTY (tty)
## ls colors
set -x LSCOLORS 'gxfxcxdxbxegedabagacad'
set -x TERM xterm-256color
## PATH
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PATH $HOME/.local/bin $HOME/.cargo/bin $HOME/.local/share/coursier/bin $PYENV_ROOT/bin

function parse_git_branch
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
end

function parse_tf_workspace
    if test -e .terraform
        if command -v terraform > /dev/null 2>&1
            terraform workspace show 2> /dev/null | sed -e 's/\(.*\)/(\1) /'
        end
    end
end

function cdr
    cd (git rev-parse --show-toplevel)
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
    set -l ENV (/usr/bin/basename (/bin/pwd))
    if test -d ~/.virtualenvs/$ENV
        source ~/.virtualenvs/$ENV/bin/activate.fish
    else
        source ~/.virtualenvs/env/bin/activate.fish
    end
end

function whatis
    curl cht.sh/$argv[1]
end

function mkapp
    cookiecutter gh:salah93/cookiecutter-python-project
end

bind -k up history-search-backward

# pyenv
if type -q pyenv
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source
end
#
#
## direnv
#
command -v direnv > /dev/null 2>&1; and eval (direnv hook fish)


#
# fzf
#
set -x FZF_DEFAULT_COMMAND 'fd --type file --color=always'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_DEFAULT_OPTS '--ansi'

set -x PYTHONSTARTUP $HOME/.config/python/shell_startup.py

if type -q op
    op completion fish | source
end
