export PATH=~/.local/bin:$PATH

eval "$(mise activate zsh --shims)"

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec Hyprland
fi
