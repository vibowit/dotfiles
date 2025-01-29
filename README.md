# Dotfiles Repository

This repository contains my personal configuration files (dotfiles) for Nix, nix-darwin, Home Manager, Neovim, Zsh, and other tools.
The setup is designed for macOS and Linux and uses Nix Flakes for reproducibility.

## Structure

```md
~/.dotfiles
├── config
│   ├── nvim        # Neovim configuration
│   ├── zsh         # Zsh configuration
│   ├── tmux        # Tmux configuration
├── nix
│   ├── flake.nix   # Main Nix flake
│   ├── home-manager
│   │   ├── home.nix
│   │   ├── modules/
│   ├── nix-darwin
│   │   ├── darwin-configuration.nix
│   │   ├── modules/
├── install.sh      # Bootstrapping script
└── README.md
```


## Installation - automatic

```sh
git clone git@github.com:vibowit/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh

nix run nixpkgs#gh -- auth login
nix run nixpkgs#gh -- repo clone vibowit/dotfiles ~/.dotfiles
nix run home-manager -- switch --flake ~/.dotfiles/nix#vibo-home
```

## Features

- Modularized Neovim setup
- Zsh with autosuggestions, syntax highlighting, and starship prompt
- Tmux configuration
- Home Manager for easy config management
- Nix Flakes for reproducibility


## Applying Changes

After modifying configuration files, apply changes with:

```sh
home-manager switch --flake ~/.dotfiles/nix

```


## Future Plans

- Add NixOS support
- Improve automation and setup scripts
- Fine-tune configurations for better performance

---

Feel free to fork and modify as needed!

