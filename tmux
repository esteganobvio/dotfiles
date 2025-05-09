set -g default-terminal "screen-256color"
set-option -ga terminal-features ',alacritty:RGB'
set-option -ga terminal-features ',xterm-256color:RGB'
#set-option -ga terminal-overrides ',xterm-kitty:Tc'
#Prefix is Ctrl-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

set -sg escape-time 1
set -g base-index 1
setw -g pane-base-index 1

#Mouse works as expected
set -g mouse on
bind -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
bind -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"
#setw -g mode-mouse on
#set -g mouse-select-pane on
#set -g mouse-resize-pane on
#set -g mouse-select-window on

setw -g monitor-activity on

set -g mode-keys vi
set -g history-limit 10000

set-option -g set-titles on
set -g set-titles-string '#{pane_title}'
#set-option -g set-titles-string "#S / #W"
# y and p as in vim
bind Escape copy-mode
unbind p
bind p paste-buffer

# extra commands for interacting with the ICCCM clipboard
bind C-c run "tmux save-buffer - | xclip -i -sel clipboard"
bind C-v run "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

# easy-to-remember split pane commands
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
unbind '"'
unbind %

# moving between panes with vim movement keys
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# moving between windows with vim movement keys
bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

# resize panes with vim movement keys
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

bind C-o display-popup -E "tms"
bind C-j display-popup -E "tms switch"
bind C-w display-popup -E "tms windows"
bind C-x confirm-before -p "Kill Session?" "run-shell 'tms kill'"
bind C-r command-prompt -p "Rename active session to: " "run-shell 'tms rename %1'"

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin "sigugo/tokyo-night-tmux"
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'mrjones2014/smart-splits.nvim'


# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
