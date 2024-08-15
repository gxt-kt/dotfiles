#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar
# pkill -f polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
# polybar top -c $HOME/.config/polybar/nord/config-top.ini &
# polybar bottom -c $HOME/.config/polybar/nord/config-bottom.ini &
#
if type "xrandr"; then
  for m in $(polybar --list-monitors | cut -d":" -f1); do
      # MONITOR=$m polybar --reload example &
      MONITOR=$m polybar top -c $HOME/.config/polybar/nord/config-top.ini &
  done
  # for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  #   # MONITOR=$m polybar --reload example &
  #   MONITOR=$m polybar top -c $HOME/.config/polybar/nord/config-top.ini &
  # done
else
  polybar top -c $HOME/.config/polybar/nord/config-top.ini &
fi
