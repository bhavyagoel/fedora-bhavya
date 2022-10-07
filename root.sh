#!/bin/bash

# ------------------------- #
# Graphical Target
# ------------------------- #
sudo systemctl set-default graphical.target

# ------------------------- #
# Hostname
# ------------------------- #

sudo hostnamectl set-hostname --static fedora

# ------------------------- #
# Resizing the root partition to fill the disk lvm #
# ------------------------- #

sudo lvresize -L +80G fedora_fedora/root && sudo xfs_growfs /dev/fedora_fedora/root


# ------------------------- #
# Modify dnf.conf       #
# ------------------------- #
echo "max_parallel_downloads=10
fastestmirror=True
defaultyes=True
" | sudo tee -a /etc/dnf/dnf.conf

# ------------------------- #
# Dependencies             #
# ------------------------- #

sudo dnf update -y && sudo dnf upgrade -y

sudo dnf groupinstall -y "Development Tools" "Development Libraries"
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


for package in $( cat packages )
do
    sudo dnf install -y $package
done

sudo systemctl enable mpd && sudo systemctl start mpd

# ------------------------- #
# Brave Browser                         #
# ------------------------- #

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# ------------------------- #
# Docker                         #
# ------------------------- #

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker && sudo systemctl start docker
sudo groupadd docker
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ${USER}

# ------------------------- #
# VS Code                         #
# ------------------------- #
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

# ------------------------- #
# Environment Configuration #
# ------------------------- #

echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment
echo "QT_STYLE_OVERRIDE=kvantum" | sudo tee -a /etc/environment


# ------------------------- #
# Startx                     #
# ------------------------- #
cp dotconfig/.xinitrc ~/


# ------------------------- #
# TLP                         #
# ------------------------- #
sudo dnf remove power-profiles-daemon
sudo systemctl enable tlp.service
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo systemctl start tlp.service

# -------------------------                 #
# Tap to Click(libinput)            #
# -------------------------                 #
echo 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection' | sudo tee -a  /etc/X11/xorg.conf.d/40-libinput.conf
