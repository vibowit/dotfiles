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


  users.users.vibo = {
    extraGroups = [ "docker" "dialout" ];
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    sudo
    tmux

    # home automation
    mosquitto
    mariadb
  ];

 
  services.mosquitto = {
    enable = true;
    # in case of problems
    # logType = [ "error" "warning" "notice" "information" "debug" ];
    listeners = [
      {
        address = "0.0.0.0"; # Listen on all interfaces
        port = 1883;
        users.mqtt = {
          acl = [
            "readwrite #"
          ];
          password = "mqtt12345";
        };
      }
    ];
  };

}
