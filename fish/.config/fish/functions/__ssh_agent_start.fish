function __ssh_agent_start -d "start a new ssh agent"
  ssh-agent -t 1800 -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
  echo set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK > $SSH_ENV;
  echo set -x SSH_AGENT_PID $SSH_AGENT_PID >> $SSH_ENV;
  source $SSH_ENV > /dev/null
end
