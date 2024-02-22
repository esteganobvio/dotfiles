#!/usr/bin/env bash

killall -q swayidle

exec swayidle -w \
  timeout 300 'swaylock' \
  timeout 600 'hyprctl  dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
  timeout 900 'systemctl suspend' \
  before-sleep 'swaylock' \
  after-resume 'hyprctl dispatch dpms on' \
  lock 'swaylock' \
  &
