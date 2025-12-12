#!/bin/bash
while true; do
    echo "WARNING:"
    echo "This script will modify your system and may overwrite existing configuration files."
    echo "Make sure you know what you're doing."
    echo
    read -p "Do you want to continue? (yes/no): " confirm

    case "$confirm" in
        yes )
            break ;;
        no )
            echo "Aborted."
            exit 1 ;;
        * )
            echo "Please type 'yes' or 'no' only."
            echo ;;
    esac
done

#   SYSTEM UPDATE + BASE SETUP
sudo pacman -Syu --needed --noconfirm base-devel git curl zsh python-pipx stow

#   DOWNLOADING RESOURCES
git clone https://github.com/sakievmi-dev/fubuki-plasma /tmp/fubuki-plasma

RESOURCES="/tmp/fubuki-plasma/resources"

#   INSTALLING YAY
if ! command -v yay &> /dev/null; then # Checking if we have yay
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    (cd /tmp/yay && makepkg -si --noconfirm)
    rm -rf /tmp/yay
fi

#   APPS
sudo pacman -S --needed --noconfirm dolphin konsole
yay -S --needed --noconfirm zen-browser-bin pfetch

pipx install --force konsave
pipx ensurepath
pipx inject konsave setuptools # this is so fucking dumb

#   KDE WIDGETS
yay -S --needed --noconfirm plasma6-applets-panel-colorizer kde-material-you-colors kwin-decoration-sierra-breeze-enhanced-git

#   CONFIGS
rm -r ~/.fubuki-dotfiles # for updates
mkdir ~/.fubuki-dotfiles

konsave -r fubuki # for updates
konsave -i $RESOURCES/fubuki.knsv
konsave -a fubuki

shopt -s dotglob
cp -r $RESOURCES/.dotfiles/* ~/.fubuki-dotfiles
shopt -u dotglob

cd ~/.fubuki-dotfiles
stow . --adopt

#   WALLPAPER
mv $RESOURCES/.wallpaper/* ~/.local/share/wallpapers/

plasma-apply-wallpaperimage ~/.local/share/wallpapers/Fubuki.png

#   OH-MY-ZSH
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

#   END
sudo rm -rf /tmp/fubuki-plasma/

echo "Setup complete! Re-login to apply all changes. Have fun!"