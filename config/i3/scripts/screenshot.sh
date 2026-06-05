#!/bin/bash
FILE=~/$(date +"%Y-%m-%d-%T")-screenshot.png

case $1 in
full)
  scrot "$FILE"
  ;;
window)
  scrot -u "$FILE"
  ;;
select)
  scrot -s "$FILE"
  ;;
esac

xclip -selection clipboard -t image/png -i "$FILE"
notify-send "Screenshot guardada y copiada"
