#!/bin/bash

# Add xorg-xdpyinfo and imagemagick
RES=$(xdpyinfo | grep dimensions | cut -d\  -f7)
RES_COLON=$(sed s/x/:/g<<<"$RES")
LOCKSCREEN="lockscreen.png"
WALLPAPER="jwst-wallpaper-cropped.png"

echo Got res $RES_COLON

cd config/wallpapers
rm $LOCKSCREEN

ffmpeg -i $WALLPAPER -vf "scale=$RES_COLON,boxblur=8" $LOCKSCREEN
clear
convert $LOCKSCREEN -font JetBrainsMono-NF-Bold -family "JetbrainsMono Nerd Font" -fill white -gravity center -pointsize 26 -annotate +0+125 'Type password to unlock' $LOCKSCREEN
