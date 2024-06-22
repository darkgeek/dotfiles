#!/bin/sh

swaymsg -t get_tree | jq -r 'recurse(.nodes[]?) | select(.name == "__i3_scratch").floating_nodes[] | ((.id | tostring) + "\t" + .name)'
