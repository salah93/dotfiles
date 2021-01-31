# on gnome edit this file /etc/xdg/autostart/gnome-keyring-ssh.desktop
# include the line X-GNOME-Autostart-enabled=false
# then restart for it to take effect
#
function start-ssh-agent
    eval (ssh-agent -t 1800 -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end
