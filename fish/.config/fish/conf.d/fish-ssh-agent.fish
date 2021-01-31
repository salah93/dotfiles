if test -e /usr/libexec/openssh/ssh-askpass
    set -x SSH_ASKPASS /usr/libexec/openssh/ssh-askpass
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if test -f $SSH_ENV
    source $SSH_ENV
end
