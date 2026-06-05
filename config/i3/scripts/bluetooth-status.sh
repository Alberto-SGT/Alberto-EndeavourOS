#!/bin/bash

# Buscar dispositivo bluetooth conectado con batería
DEVICE=$(upower -e | grep headset)

if [ -n "$DEVICE" ]; then
  BATTERY=$(upower -i "$DEVICE" | grep percentage | awk '{print $2}')
  echo "󰋋 $BATTERY"
else
  echo "󰂯"
fi
