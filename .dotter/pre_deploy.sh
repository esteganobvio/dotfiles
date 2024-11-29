if [ ! -f "$HOME"/.local/bin/mise ]; then
  curl https://mise.run | sh
fi

if [ ! -d "$HOME"/.oh-my-zsh ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
fi
