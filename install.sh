#!/usr/bin/env bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
GIT_REPO="git@github.com:vibowit/dotfiles.git"

# Clone the dotfiles repository
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Cloning dotfiles repository..."
    git clone "$GIT_REPO" "$DOTFILES_DIR"
else
    echo "Dotfiles repository already exists. Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
fi

# Ensure Nix is installed
if ! command -v nix &> /dev/null; then
    echo "Installing Nix..."
    curl -L https://nixos.org/nix/install | sh
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

# Ensure Home Manager is installed
if [ ! -d "$HOME/.config/nix" ]; then
    echo "Setting up Home Manager..."
    nix --experimental-features 'nix-command flakes' run home-manager/master -- init --switch --flake "$DOTFILES_DIR"
fi

# Apply Home Manager configuration
home-manager switch --flake "$DOTFILES_DIR"

echo "Dotfiles setup complete!"
