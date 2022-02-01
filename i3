set $mod Mod4

set $left h
set $down j
set $up k
set $right l


exec xrdb -load ~/.Xresources

set $gnome-schema org.gnome.desktop.interface

#exec_always {
#    gsettings set $gnome-schema gtk-theme 'Arc-Dark'
#    gsettings set $gnome-schema icon-theme 'Paper'
#    gsettings set $gnome-schema cursor-theme 'Paper'
#    gsettings set $gnome-schema font-name 'Roboto 8'
#}

#set $background nitrogen --restore

set $term alacritty

set $menu rofi -show

set $lock i3lock -n -i /home/dixie/Pictures/wp6600254-serial-experiments-lain-wallpapers.png

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:FuraCode Nerd Font 9
for_window [class="^.*"] border pixel 1
# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec $term

# kill focused window
bindsym $mod+Shift+c kill

# start dmenu (a program launcher)
bindsym $mod+p exec $menu
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop
exec $background

exec xss-lock -- $lock

exec picom

exec dunst

#exec keepassxc


# change focus
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+b split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# Define names for default workspaces for which we configure key bindings later on.
# We use variables to avoid repeating the names in multiple places.
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"

# switch to workspace
bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5
bindsym $mod+6 workspace $ws6
bindsym $mod+7 workspace $ws7
bindsym $mod+8 workspace $ws8
bindsym $mod+9 workspace $ws9
bindsym $mod+0 workspace $ws10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5
bindsym $mod+Shift+6 move container to workspace $ws6
bindsym $mod+Shift+7 move container to workspace $ws7
bindsym $mod+Shift+8 move container to workspace $ws8
bindsym $mod+Shift+9 move container to workspace $ws9
bindsym $mod+Shift+0 move container to workspace $ws10

bindsym $mod+Shift+Mod1+$left move workspace to output left
bindsym $mod+Shift+Mod1+$down move workspace to output down
bindsym $mod+Shift+Mod1+$up move workspace to output up
bindsym $mod+Shift+Mod1+$right move workspace to output right

bindsym $mod+Shift+Mod1+Left move workspace to output left
bindsym $mod+Shift+Mod1+Down move workspace to output down
bindsym $mod+Shift+Mod1+Up move workspace to output up
bindsym $mod+Shift+Mod1+Right move workspace to output right

bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute exec pactl set-source-mute alsa_input.pci-0000_00_1b.0.analog-stereo toggle
bindsym XF86MonBrightnessDown exec brightnessctl s 5%-
bindsym XF86MonBrightnessUp exec brightnessctl s +5%

bindsym $mod+m exec dunstctl close
bindsym $mod+Shift+m exec dunstctl close-all
bindsym $mod+Mod1+m exec dunstctl history-pop
bindsym $mod+Ctrl+m exec dunstctl context

bindsym $mod+x exec $lock

# reload the configuration file
#bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+q exit

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
}

bindsym $mod+r mode "resize"

set $bg-color            #2f343f
set $inactive-bg-color   #2f343f
set $text-color          #f3f4f5
set $inactive-text-color #676E7D
set $urgent-bg-color     #5294e2

# windows           Border    Background    Text     Indicator
client.focused        #2f343f   #2f343f       #676E7D  #5294e2 #5294e2
client.unfocused      #2f343f   #2f343f       #ffffff  #676E7D #2f343f


# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  id top
  position top
  status_command i3status-rs ~/.config/i3/i3status-top.toml
  mode dock
  colors {
    background $bg-color
    separator #757575
    focused_workspace  $bg-color          $bg-color          $text-color
    inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
    urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
  }
}



bar {
  id bottom
  position bottom
  status_command i3status-rs ~/.config/i3/i3status-bottom.toml
  mode dock
  tray_output none
  colors {
    background $bg-color
    separator #757575
    focused_workspace  $bg-color          $bg-color          $text-color
    inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
    urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
  }
}

# Gnome
exec --no-startup-id /usr/lib/gnome-settings-daemon/gsd-xsettings
exec_always --no-startup-id gnome-power-manager
exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
#exec --no-startup-id gnome-flashback


for_window [class="KeePassXC"] floating enable
for_window [class="openrgb"] floating enable
for_window [class="corectrl"] floating enable
for_window [class="Blueman-manager"] floating enable