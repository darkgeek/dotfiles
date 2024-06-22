#!/bin/bash
read -r id name <<< $(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?) | select(.name == "__i3_scratch").floating_nodes[] | ((.id | tostring) + "\t" + .name)' | rofi -dmenu -p "scratchpad")
swaymsg "[con_id=$id]" focus

