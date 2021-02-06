set -x DISPLAY :0
if test -e /usr/libexec/openssh/ssh-askpass
    set -x SSH_ASKPASS /usr/libexec/openssh/ssh-askpass
else if type -q ssh-askpass
    set -x SSH_ASKPASS (which ssh-askpass)
end

if test -z $SSH_ENV
    set -xg SSH_ENV $HOME/.ssh/environment
end

if test -f $SSH_ENV
    source $SSH_ENV
end
