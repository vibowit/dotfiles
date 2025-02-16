{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Core development
    go_1_22
    gopls
    golangci-lint
    delve
    go-tools
    python3
    python3Packages.pip
    python3Packages.virtualenv
    poetry

    # Terminal & CLI tools
    gh
    jq
    curl
    ripgrep
    fd
    fzf
    direnv
    nix-direnv

    # Formatters & Linters
    nodePackages.prettier
    python3Packages.black
    python3Packages.flake8
    pre-commit

  ];
}
