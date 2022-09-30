#!/bin/bash

# ------------------------- #
# Themeing GTK
# ------------------------- #

git clone https://github.com/catppuccin/gtk.git
cd gtk
./install.sh
./gtkrc.sh 
sudo ./gtkrc.sh 
cd ..
rm -rf gtk

# ------------------------- #
# Themeing Kvantum
# ------------------------- #

git clone https://github.com/catppuccin/Kvantum.git


# ------------------------- #
# Rofi
# ------------------------- #

git clone https://github.com/catppuccin/rofi.git
cd rofi/basic/
bash install.sh
cd ../..
rm -rf rofi


# ------------------------- #
# Nerd-fonts
# ------------------------- #
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh
fc-cache -fv
sudo ./install.sh && sudo fc-cache -fv
cd ..
rm -rf nerd-fonts


# ------------------------- #
# Awesome
# ------------------------- #

cp -r dotconfig/awesome ~/.config/

# ------------------------- #
# ZSH
# ------------------------- #

git clone https://github.com/yutkat/dotfiles
cp -r dotfiles/.config/zsh ~/.config/
cp -r dotfiles/.zshenv ~/
exec zsh
rm -rf dotfiles
chsh -s $(which zsh)

cp dotfiles/mocha.sh ~/.config/zsh/

echo 'export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

neofetch | lolcat

source  ~/.config/zsh/mocha.sh' | sudo tee -a ~/.config/zsh/.zshrc

cp dotfile/.zprofile ~/.config/zsh 