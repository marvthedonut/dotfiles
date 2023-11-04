#!/bin/bash

mkdir cache
cd cache/

curl -sOL https://github.com/BetterDiscord/Installer/releases/latest/download/BetterDiscord-Linux.AppImage
chmod +x BetterDiscord-Linux.AppImage
./BetterDiscord-Linux.AppImage --appimage-extract
cd squashfs-root
sudo chown $USER:$USER ~/.config/BetterDiscord/
./betterdiscord-installer
cd ..

cd ..
rm -rf cache/
