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

sudo lvresize -L +206G fedora/root && sudo xfs_growfs /dev/fedora/root


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

sudo dnf update && sudo dnf upgrade

sudo dnf groupinstall -y "Development Tools" "Development Libraries"
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

packages = $( cat packages )
for package in $packages
do
    sudo dnf install -y $package
done

sudo systemctl enable mpd && sudo systemctl start mpd

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser


sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker && sudo systemctl start docker
sudo groupadd docker
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ${USER}


# ------------------------- #
# Environment Configuration #
# ------------------------- #

echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment
echo "QT_STYLE_OVERRIDE=kvantum" | sudo tee -a /etc/environment


# ------------------------- #
# Startx                    #
# ------------------------- #
cp dotfiles/.xinitrc ~/