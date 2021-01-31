function kill-ssh-agent
    killall ssh-agent
    set -e SSH_AGENT_PID
    set -e SSH_AUTH_SOCK
end
