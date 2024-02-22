#!/usr/bin/env bash

killall -q swayidle

exec swayidle -w \
  timeout 300 'swaylock' \
  timeout 600 'swaymsg "output * dpms off' \
    resume 'swaymsg "output * dpms on"' \
  timeout 900 'systemctl suspend' \
  before-sleep 'swaylock' \
  after-resume 'swaymsg "output * dpms on"' \
  lock 'swaylock' \
  &
