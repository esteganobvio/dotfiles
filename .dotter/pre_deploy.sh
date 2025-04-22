if [ ! -f "$HOME"/.local/bin/mise ]; then
  curl https://mise.run | sh
fi

if [ ! -d "$HOME"/.oh-my-zsh ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
fi

if [ ! -d "$HOME"/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME"/.tmux/plugins/tpm
fi


