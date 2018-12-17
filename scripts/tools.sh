#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update 
apt-get install -y vim wget net-tools locales bzip2 \
	xvfb \
	xterm \
	sudo x11-xserver-utils \
    	python-numpy #used for websockify/novnc
apt-get clean -y


# install i3
wget http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb
dpkg -i sur*
rm sur*.deb
echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" >> /etc/apt/sources.list.d/sur5r-i3.list
apt-get update && apt-get install -y i3 && apt-get clean -y

echo "generate locales für en_US.UTF-8"
locale-gen en_US.UTF-8
