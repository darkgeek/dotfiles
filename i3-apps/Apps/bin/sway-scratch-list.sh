#!/bin/bash
read -r id name <<< $($HOME/Apps/bin/sway-show-scratchpad.sh | rofi -dmenu -p "scratchpad")
swaymsg "[con_id=$id]" focus

