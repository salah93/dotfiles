# on gnome edit this file /etc/xdg/autostart/gnome-keyring-ssh.desktop
# include the line X-GNOME-Autostart-enabled=false
# then restart for it to take effect
function start-ssh-agent
    eval (ssh-agent -t 1800 -c)
    echo set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK > $SSH_ENV
    echo set -x SSH_AGENT_PID $SSH_AGENT_PID >> $SSH_ENV
    chmod 600 $SSH_ENV
    source $SSH_ENV > /dev/null 2>&1
end
