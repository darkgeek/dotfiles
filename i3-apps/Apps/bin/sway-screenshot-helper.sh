#!/bin/sh

OPTION_WHOLE_DESKTOP="Whole Desktop"
OPTION_SELECT_REGION="Select a region"

user_selection=$(printf "$OPTION_WHOLE_DESKTOP\n$OPTION_SELECT_REGION" | rofi -dmenu -p "Screenshot")
if [ "$user_selection" == "$OPTION_WHOLE_DESKTOP" ]; then
	echo capture whole desktop...
	grim
elif [ "$user_selection" == "$OPTION_SELECT_REGION" ]; then
	echo capture only user selected...
	grim -g "$(slurp)"
else
	echo illegal option.
fi
