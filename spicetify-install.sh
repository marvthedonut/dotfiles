#!/bin/bash

mkdir cache
cd cache

# AUR Build tools
sudo pacman -Sy --noconfirm base-devel devtools

git clone https://aur.archlinux.org/spicetify-cli.git
cd spicetify-cli
makepkg -si
cd ..
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

cd .. 
rm -rf cache/
