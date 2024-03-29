set $mod Mod4

set $left h
set $down j
set $up k
set $right l


exec xrdb -load ~/.Xresources
#exec xrandr --output eDP-1 --mode 2048x1152
set $gnome-schema org.gnome.desktop.interface

#exec_always {
#    gsettings set $gnome-schema gtk-theme 'Arc-Dark'
#    gsettings set $gnome-schema icon-theme 'Paper'
#    gsettings set $gnome-schema cursor-theme 'Paper'
#    gsettings set $gnome-schema font-name 'Roboto 8'
#}

set $background nitrogen --restore

set $term alacritty

set $menu rofi -show

set $lock loginctl lock-session

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
font pango:{{font_family}} 10
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
exec --no-startup-id $background

#exec --no-startup-id xss-lock $lock

exec --no-startup-id picom

exec --no-startup-id dunst

exec --no-startup-id nm-applet

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
set $ws1 "1:"
set $ws2 "2:󰖟"
set $ws3 "3:"
set $ws4 "4:"
set $ws5 "5:"
set $ws6 "6:"
set $ws7 "7:"
set $ws8 "8:"
set $ws9 "9:"
set $ws10 "10:"

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

bindsym XF86AudioRaiseVolume exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+
bindsym XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
bindsym XF86AudioMute exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindsym XF86AudioMicMute exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindsym XF86MonBrightnessDown exec brightnessctl s 1%-
bindsym XF86MonBrightnessUp exec brightnessctl s +1%
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
bindsym XF86AudioPlay exec playerctl play-pause

bindsym $mod+m exec dunstctl close
bindsym $mod+Shift+m exec dunstctl close-all
bindsym $mod+Mod1+m exec dunstctl history-pop
bindsym $mod+Ctrl+m exec dunstctl context

bindsym $mod+Escape exec $lock

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

gaps inner 0
gaps outer 0

set $bg-color            #0D0F14
set $inactive-bg-color   #0D0F14
set $text-color          #5294e2
set $inactive-text-color #30343D
set $urgent-bg-color     #900000

# windows               border    backgr.   text     indicator child_border
client.focused          #5294e2   #5294e2   #0D0F14   #5294e2  #5294e2
client.unfocused        #0D0F14   #0D0F14   #f3f4f5   #30343D  #0D0F14
client.focused_inactive #0D0F14   #0D0F14   #30343D   #30343D  #0D0F14
client.urgent           #0D0F14   #900000   #f3f4f5   #900000  #900000

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  id top
  position top
  status_command i3status-rs ~/.config/i3status/i3status-top.toml
  mode dock
  #tray_output primary
  strip_workspace_numbers yes
  strip_workspace_name no
  workspace_buttons no
  colors {
    background $bg-color
    separator #30343D
    focused_workspace  $bg-color          $bg-color          $text-color
    active_workspace  $bg-color          $bg-color          $inactive-text-color
    inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
    urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
  }
}



bar {
  id bottom
  position bottom
  status_command i3status-rs ~/.config/i3status/i3status-bottom.toml
  mode dock
  tray_output none
  workspace_buttons yes
  strip_workspace_numbers yes
  strip_workspace_name no
  colors {
    background $bg-color
    separator #30343D
    focused_workspace  $bg-color          $bg-color          $text-color
    active_workspace  $bg-color          $bg-color          $inactive-text-color
    inactive_workspace $inactive-bg-color $inactive-bg-color $inactive-text-color
    urgent_workspace   $urgent-bg-color   $urgent-bg-color   $text-color
  }
}

{{#if (is_executable "yay")}}
exec --no-startup-id /usr/lib/gsd-xsettings
exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
{{else}}
exec --no-startup-id /usr/libexec/gsd-xsettings
exec --no-startup-id /usr/libexec/polkit-gnome-authentication-agent-1
{{/if}}
exec_always --no-startup-id gnome-power-manager
exec --no-startup-id gnome-flashback


for_window [class="KeePassXC"] floating enable
for_window [class="openrgb"] floating enable
for_window [class="corectrl"] floating enable
for_window [class="Blueman-manager"] floating enable
for_window [class="Virt-manager"] floating enable
for_window [class="Qemu-system-x86_64"] floating enable
#for_window [class="zoom"] floating enable
for_window [title="^zoom$" class="[zoom]*"] floating enable
for_window [class="protonvpn"] floating enable
for_window [class="gnome-calculator"] floating enable
for_window [class="battle.net.exe"] floating enable
for_window [class="bottles"] floating enable
# vim: ft=i3config :
