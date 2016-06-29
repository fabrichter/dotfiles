#!/bin/bash
xbindkeys &
xrdb -merge ~/.Xresources &
xmodmap .Xmodmap &
xrandr --output eDP1 --left-of DP1 &
exec /home/fabian/run/monitor &
compton -b &
emacs &
xsetroot -cursor_name left_ptr &
sudo tlp start
