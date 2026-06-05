#!/bin/bash
case $1 in
up) brightnessctl -d amdgpu_bl1 set 5%+ ;;
down) brightnessctl -d amdgpu_bl1 set 5%- ;;
esac
