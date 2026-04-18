#!/bin/bash
cd "$(dirname "$0")"

echo "Stowing dotfiles..."
stow bash dunst emacs fastfetch git mimeapps nvim scripts vim xinitrc yazi gtk

echo "Stowing system files (requires sudo)..."
sudo stow --target=/usr/local/bin system

echo "Done!"
