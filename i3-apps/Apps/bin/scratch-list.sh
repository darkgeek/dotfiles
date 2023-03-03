#!/bin/sh
$HOME/go/bin/i3-scratch-list  | rofi -dmenu -i -p "scratchpad" | perl -nE 'my($id) = split("-");  $id =~ tr/ //d; if($id){say $id}' | xargs -i{} i3-msg "[id=\""{}"\"] scratchpad show"

