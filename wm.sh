#!/bin/bash
unset XDG_RUNTIME_DIR
Xephyr -br -ac -resizeable :2 &
sleep 1
DISPLAY=:2 i3
pkill Xephyr
