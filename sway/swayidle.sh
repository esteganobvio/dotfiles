#!/usr/bin/env bash

killall -q swayidle

exec swayidle -w \
  timeout 300 'swaymsg "output * dpms off"; swaylock -f -c 000000' \
    resume 'swaymsg "output * dpms on"' \
  timeout 600 'systemctl suspend' \
    resume 'swaymsg "output * dpms on"' \
  before-sleep 'swaylock -f -c 000000' \
  after-resume 'swaymsg "output * dpms on"' \
  lock 'swaylock -f -c 000000' \
  &
