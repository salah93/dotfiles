if test -e /usr/libexec/openssh/ssh-askpass
    set -x SSH_ASKPASS /usr/libexec/openssh/ssh-askpass
end

if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end
