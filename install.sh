#!/bin/bash

#   CHECKING IF PLASMA IS RUNNING
if [[ "${XDG_CURRENT_DESKTOP:-}" != *KDE* && "${XDG_CURRENT_DESKTOP:-}" != *Plasma* ]]; then
    echo "Error: KDE Plasma is not running. Aborting."
    echo "To install fubuki-plasma you should use KDE Plasma."

    exit 1 # If not, just exit
fi

#   INSTALLING SCRIPTS
echo "Installing scripts into /usr/bin..."

sudo rm ~/.local/bin/fubuki-install
sudo rm ~/.local/bin/fubuki-cheatsheet

install -m 755 scripts/fubuki-install.sh ~/.local/bin/fubuki-install
install -m 755 scripts/fubuki-cheatsheet.sh ~/.local/bin/fubuki-cheatsheet