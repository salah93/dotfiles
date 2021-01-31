# on gnome edit this file /etc/xdg/autostart/gnome-keyring-ssh.desktop
# include the line X-GNOME-Autostart-enabled=false
# then restart for it to take effect
#
if test -e /usr/libexec/openssh/ssh-askpass
    set -Ux SSH_ASKPASS /usr/libexec/openssh/ssh-askpass
end
