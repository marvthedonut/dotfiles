# Touchpad Support
For touchpad support (chromebook taps) you need libinput and xorg-xinput installed then run the following commands

Find the device number using `xinput list`
then enable moving mouse while typing using `xinput set-prop <device_number> "libinput Disable While Typing Enabled" 0`
Enable taps (two tap equal rightclick) `xinput set-prop <device_number> "libinput Click Method Enabled" 0 1"
