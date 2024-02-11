#!/usr/bin/env bash

exec swayidle -w \
  timeout 300 'swaylock' \
  timeout 600 'hyprctl  dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
  timeout 900 'systemctl suspend' \
  before-sleep 'swaylock' \
  lock 'swaylock'
