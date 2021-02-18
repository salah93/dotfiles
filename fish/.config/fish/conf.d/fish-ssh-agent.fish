if test -e /usr/libexec/openssh/ssh-askpass
    set -x SSH_ASKPASS /usr/libexec/openssh/ssh-askpass
else if type -q ssh-askpass
    set -x SSH_ASKPASS (which ssh-askpass)
end

if test -z $SSH_ENV
    set -xg SSH_ENV $HOME/.ssh/environment
end

pgrep -fq "ssh-agent -t 1800 -c"
set -l ssh_agent_is_running $status

if test -f $SSH_ENV
   and test $ssh_agent_is_running -eq 0
    source $SSH_ENV > /dev/null 2>&1
else
    kill-ssh-agent
end
