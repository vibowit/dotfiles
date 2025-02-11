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

    # home automation
    # mosquitto
    podman
    # mariadb
  ];

  services.home-assistant = {
    enable = true;
    configDir = "/var/lib/hass";
    configWritable = true;
    config = {
      # defaultConfig = {};
      homeassistant = {
        unit_system = "metric";
        homeassistant.time_zone = "Europe/Warsaw";
      };
      recorder.db_url = "mysql://homeassistant:yourpassword@localhost/homeassistant?charset=utf8mb4";
    };
    extraComponents = [
      "esphome"    # Required for device discovery
      "met"        # Weather integration base
      "radio_browser"
    ];
    extraPackages = python3Packages: [
      python3Packages.psycopg2
      python3Packages.mysqlclient
      python3Packages.numpy
      python3Packages.gtts
    ];

  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureDatabases = [ "homeassistant" ];
    ensureUsers = [{
      name = "homeassistant";
      ensurePermissions = { "homeassistant.*" = "ALL PRIVILEGES"; };
    }];

    settings.mysqld = {
      innodb_buffer_pool_size = "512M";
      query_cache_type = 1;
      thread_cache_size = 32;
    };
  };

 
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
