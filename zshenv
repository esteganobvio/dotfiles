#export PATH=$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/bin
. "$HOME/.cargo/env"
export CLOUDSDK_PYTHON=python3

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/var/home/dixie/google-cloud-sdk/path.zsh.inc' ]; then . '/var/home/dixie/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/var/home/dixie/google-cloud-sdk/completion.zsh.inc' ]; then . '/var/home/dixie/google-cloud-sdk/completion.zsh.inc'; fi

export MISE_EXPERIMENTAL=true
export GTK_IM_MODULE=simple
#export DMS_DISABLE_MATUGEN=1
export VAULT_ADDR=https://secrets.podcastapp.io/
