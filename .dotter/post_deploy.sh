#{{#if dotter.packages.systemd-user}}
#systemctl enable --now --user gnome-keyring-daemon
#{{/if}}

#{{#if dotter.packages.noctalia}}
if command -v noctalia >/dev/null 2>&1; then
  noctalia config validate ~/.config/noctalia
fi
#{{/if}}
