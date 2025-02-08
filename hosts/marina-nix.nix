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

}
