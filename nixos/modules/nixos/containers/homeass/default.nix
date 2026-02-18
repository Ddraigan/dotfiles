{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.nix.containers.homeass;
  mainUser = "leon";
  dataPath = "${config.users.users.${mainUser}.home}/appdata";
  homeassPath = "${dataPath}/homeass";
in {
  options.modules.nix.containers.homeass.enable = lib.mkEnableOption "Enable Home Assistant Container";
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${homeassPath} 0755 ${mainUser} ${mainUser} -"
    ];
    networking.firewall.allowedTCPPorts = [8123];
    virtualisation.oci-containers.containers.homeass = {
      image = "ghcr.io/home-assistant/home-assistant:stable";
      autoStart = true;
      volumes = [
        "/etc/localtime:/etc/localtime:ro"
        "${homeassPath}:/config"
        "/run/dbus:/run/dbus:ro"
      ];
      devices = [
        "/dev/ttyUSB0:/dev/ttyUSB0"
      # "/dev/serial/by-id/usb-YourStickID:/dev/ttyUSB0" # Better way to mount usb
      ];
      ports = [
        "8123:8123"
      ];
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--cap-add=NET_RAW"
      ];
      environment = {
        TZ = config.time.timeZone;
      };
    };
  };
}
