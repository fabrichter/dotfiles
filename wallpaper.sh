#!/bin/sh
cd "$HOME/Wallpapers"
feh --bg-fill `ls -1 $HOME/Wallpapers/ | shuf -n 1`
