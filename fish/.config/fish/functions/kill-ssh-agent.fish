function kill-ssh-agent
    killall ssh-agent > /dev/null 2>&1
    set -e SSH_AGENT_PID
    set -e SSH_AUTH_SOCK
    rm $SSH_ENV > /dev/null 2>&1
end
