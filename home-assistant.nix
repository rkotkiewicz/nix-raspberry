{ inputs, lib, config, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "met"
      "default_config"
      "mqtt"
    ];
    config = {
      default_config = {};
      automation = "!include automations.yaml";
    };
  };


    services.zigbee2mqtt = {
      enable = true;
      settings = {
        mqtt = {
          base_topic = "zigbee2mqtt";
          server = "mqtt://localhost:1883";
        };

        frontend = {
          port = 8080;
        };
        serial = {
          port = "/dev/ttyUSB0";
          baudrate = 115200;
          adapter = "zstack";
        };

      };
    };

      systemd.services.zigbee2mqtt = {
        requires = [
        "mosquitto.service"
        "network-online.target"];


        after = [ "mosquitto.service" "network-online.target" ];
      };

    services.mosquitto = {
      enable = true;
      settings = {
      };
    };
}
