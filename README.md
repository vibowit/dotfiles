# Dotfiles

This repository contains my personal dotfiles managed with Nix Flakes, covering
configurations for:

- **NixOS**
- **macOS (nix-darwin)**
- **Home Manager**
- **Neovim, Zsh, and other CLI tools**

## 📂 Repository Structure

```
~/.dotfiles
├── flake.nix
├── flake.lock
├── nixos/
│   ├── hosts/
│   │   ├── host1.nix
│   │   ├── host2.nix
│   ├── modules/
│   │   ├── common.nix
│   │   ├── hardware-configuration.nix
├── darwin/
│   ├── darwin-configuration.nix
│   ├── modules/
│   │   ├── common.nix
├── home-manager/
│   ├── users/
│   │   ├── user1.nix
│   │   ├── user2.nix
│   ├── modules/
│   │   ├── zsh.nix
│   │   ├── nvim.nix
├── config/
│   ├── nvim/
│   ├── zsh/
│   ├── tmux/
├── README.md
```

## 🛠 Installing Nix

Before setting up the dotfiles, ensure that Nix is installed on your system.

### Install Nix on Linux & macOS

```sh
curl -L https://nixos.org/nix/install | sh
```

### Enable Flakes & Experimental Features

Modify `~/.config/nix/nix.conf` (create it if necessary) and add:

```sh
experimental-features = nix-command flakes
```

For NixOS, ensure these options are set in `/etc/nixos/configuration.nix`:

```nix
{ config, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
```

Then apply the changes:

```sh
sudo nixos-rebuild switch
```

## 🚀 Installation & Setup

### 1️⃣ Clone the Repository

```sh
git clone https://github.com/vibowit/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 2️⃣ Apply NixOS Configuration

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles#host1
```

### 3️⃣ Apply macOS (nix-darwin) Configuration

```sh
darwin-rebuild switch --flake ~/.dotfiles#macbook
```

### 4️⃣ Apply Home Manager Configuration

```sh
home-manager switch --flake ~/.dotfiles#user1
```

## 🛠 Features

- **Fully reproducible system configurations** for both Linux & macOS
- **Modular Home Manager setup** for user environments
- **Neovim, Zsh, Tmux preconfigured**
- **Nix Flakes for better dependency management**

## 📜 License

MIT License. Feel free to use and modify as needed!

---

Maintained by [vibowit](https://github.com/vibowit).
