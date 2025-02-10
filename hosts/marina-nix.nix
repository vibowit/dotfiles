{ config, pkgs, lib, ... }:

{
  imports = [ ./base.nix ];

  networking.hostName = "marina-nix";
  networking.interfaces.ens18.ipv4.addresses = [{
    address = "192.168.1.37";
    prefixLength = 24;
  }];

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  virtualisation.docker.enable = true;

  users.users.vibo = {
    extraGroups = [ "docker" "dialout" ];
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    sudo
    tmux
  ];

}
