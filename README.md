# 🛠 Dotfiles Repository

This repository contains my personal dotfiles managed with Nix Flakes,
supporting:

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

## 🔧 Features

- **Fully reproducible system configurations** for Linux & macOS
- **Modular Home Manager setup** for flexible user environments
- **Preconfigured Neovim, Zsh, and Tmux**
- **Nix Flakes for improved dependency management**
- **Easy deployment with a single command**

## 📜 License

This project is licensed under the **MIT License**. Feel free to use and modify
it as needed!

---

💻 Maintained by [vibowit](https://github.com/vibowit).
