#!/bin/bash

mkdir cache
cd cache

sudo pacman -S base-devel --noconfirm
git clone https://aur.archlinux.org/i3lock-color.git
cd i3lock-color
makepkg -si

cd ..
cd ..
rm -rf cache
