#{{#if dotter.packages.systemd-user}}
#systemctl enable --now --user gnome-keyring-daemon
#{{/if}}
#{{#if dotter.packages.waybar}}
#killall waybar
#waybar &
#{{/if}}
