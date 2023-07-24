#!/bin/bash

string=$1
if [ "$1" == "vol" ]
then
  mute=$(amixer get Master | grep -oE '\[(on|off)\]' | head -1 | tr -d '[]')
  if [[ "$mute" == "off" ]]; then
    # 静音状态
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.volumeChanged 0
    notify-send "Volume Mute!" -i /usr/share/icons/Mkos-Big-Sur/128x128/devices/audiocard_mute.png -u critical -t 1000
    bash ~/.scripts/dunst/sound-normal.sh 
    echo "off"
  else
    # 非静音状态
    volume=$(amixer get Master | grep -o -E '[0-9]{1,3}%' | head -1 | cut -d'%' -f1)
    qdbus org.kde.plasmashell /org/kde/osdService org.kde.osdService.volumeChanged ${volume}
    notify-send -a "Volume" -i /usr/share/icons/Mkos-Big-Sur/128x128/devices/audiocard.png -h int:value:${volume} "Volume"
    bash ~/.scripts/dunst/sound-normal.sh 
    echo ${volume} 
  fi
elif [ "$1" == "backlight" ]
then
  notify-send -a "Backlight" -i /usr/share/icons/Mkos-Big-Sur/128x128/devices/system.svg -h int:value:`light` "Backlight"
else
  echo "无效指令"
fi

