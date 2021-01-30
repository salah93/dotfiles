if test -z (pgrep ssh-agent)
  eval (ssh-agent -t 1800 -c)
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end
