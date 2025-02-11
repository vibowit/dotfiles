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

  networking.firewall = {
    allowedTCPPorts = [8123];  # Home Assistant web interface
    interfaces.podman0.allowedUDPPorts = [53];  # DNS resolution
  };


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


  # enable podman and it's nixos module
  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";

  # define the mosquitto container
  virtualisation.oci-containers.containers.mosquitto = {
    image = "eclipse-mosquitto:2";
    volumes = [
      "/srv/homelab/mosquitto/config:/mosquitto/config"
      "/srv/homelab/mosquitto/data:/mosquitto/data"
      # "${pkgs.writeText "mosquitto.conf" ''
      #   listener 1883
      #   allow_anonymous false
      #   password_file /mosquitto/config/passwd
      # ''}:/mosquitto/config/mosquitto.conf"
    ];
    ports = ["1883:1883"]; # MQTT port
    environment = {
      TZ = "Europe/Warsaw";
    };
    autoStart = true;
    extraOptions = [ "--log-driver=journald" ];
  };

  # ensure the persistent directory exists
  systemd.tmpfiles.rules = [
    "d /srv/homelab/mosquitto/config 0755 root root -"
    "d /srv/homelab/mosquitto/data 0755 root root -"
  ];

}
