#!/bin/bash
if ! hash spotify 2>/dev/null; then
	curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | gpg --import -
	git clone https://aur.archlinux.org/spotify.git
	cd spotify
	makepkg -si
	cd ..
	rm -rf spotify/
fi
if hash spotify 2>/dev/null; then
	sudo pacman -Sy --needed unzip zip
	git clone https://aur.archlinux.org/spotx-git.git
	cd spotx-git
	makepkg -si
	spotx
	cd ..
	rm -rf spotx-git/

	./spicetify-install.sh
fi
