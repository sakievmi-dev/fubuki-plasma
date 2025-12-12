#!/bin/bash
sudo pacman -S --needed --noconfirm git

#   CHECKING IF PLASMA IS RUNNING
if [[ "${XDG_CURRENT_DESKTOP:-}" != *KDE* && "${XDG_CURRENT_DESKTOP:-}" != *Plasma* ]]; then
    echo "Error: KDE Plasma is not running. Aborting."
    echo "To install fubuki-plasma you should use KDE Plasma."

    exit 1 # If not, just exit
fi

#   INSTALLING SCRIPTS
git clone https://github.com/sakievmi-dev/fubuki-plasma /tmp/fubuki-plasma

echo "Installing scripts into /usr/bin..."

sudo rm /usr/bin/fubuki-install
sudo rm /usr/bin/fubuki-cheatsheet

sudo install -m 755 /tmp/fubuki-plasma/scripts/fubuki-install.sh /usr/bin/fubuki-install
sudo install -m 755 /tmp/fubuki-plasma/scripts/fubuki-cheatsheet.sh /usr/bin/fubuki-cheatsheet

rm -rf /tmp/fubuki-plasma/

#   DONE
echo "Done! Use 'fubuki-install' to install fubuki-plasma setup."