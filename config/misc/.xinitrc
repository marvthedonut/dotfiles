xinput set-prop "Elan Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "Elan Touchpad" "libinput Click Method Enabled" 0 1
xinput set-prop "Elan Touchpad" "libinput Disable While Typing Enabled" 0
numlockx &
~/dotfiles/lock.sh
exec i3
