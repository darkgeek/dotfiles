#!/bin/sh

grim $HOME/Desktop/current-desktop.png && convert $HOME/Desktop/current-desktop.png -blur 0x8 $HOME/Desktop/current-desktop.png && swaylock -f -i $HOME/Desktop/current-desktop.png
