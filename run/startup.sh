#!/bin/bash
xbindkeys &
mpd ~/.mpd/mpd.conf &
xrdb -merge ~/.Xresources &
xmodmap .Xmodmap &
xrandr --output eDP1 --left-of DP1 &
exec /home/fabian/run/monitor &
feh --bg-scale wallpaper/planets.jpg &
compton -b &
emacs &
