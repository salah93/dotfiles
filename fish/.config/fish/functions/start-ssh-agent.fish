# on gnome edit this file /etc/xdg/autostart/gnome-keyring-ssh.desktop
# include the line X-GNOME-Autostart-enabled=false
# then restart for it to take effect
function start-ssh-agent
    set -gx DISPLAY :0
    eval (ssh-agent -t 1800 -c)
    echo set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK > $SSH_ENV
    echo set -gx SSH_AGENT_PID $SSH_AGENT_PID >> $SSH_ENV
    # WARNING - setting display in startup results in login loop in gnome!!
    echo set -gx DISPLAY :0 >> $SSH_ENV
    chmod 600 $SSH_ENV
    source $SSH_ENV > /dev/null 2>&1
end
