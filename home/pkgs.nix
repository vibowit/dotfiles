{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go_1_22
    gopls
    golangci-lint
    delve
    go-tools
    python3
    python3Packages.pip
    python3Packages.virtualenv
    poetry
    wezterm
    starship
    zsh
    gh
    jq
    curl
    ripgrep
    fd
    fzf
    direnv
    nix-direnv
    nodePackages.prettier
    python3Packages.black
    python3Packages.flake8
    pre-commit
  ];
}
