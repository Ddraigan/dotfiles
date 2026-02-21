{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.nix.containers;
  homeassPath = "${cfg.dataPath}/homeass";
in {
  options.modules.nix.containers.homeass.enable = lib.mkEnableOption "Enable Home Assistant Container";
  config = lib.mkIf cfg.homeass.enable {
    systemd.tmpfiles.rules = [
      "d ${homeassPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
    ];
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
      extraOptions = [
        "--cap-add=NET_ADMIN"
        "--cap-add=NET_RAW"
      ];
      environment = {
        TZ = config.time.timeZone;
      };
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.homeass.rule" = "Host(\`homeass.${cfg.domain}\`)";
        "traefik.http.routers.homeass.entrypoints" = "websecure";
        "traefik.http.routers.homeass.tls.certresolver" = "certresolver";
        "traefik.http.services.homeass.loadbalancer.server.port" = "8123";
      };
    };
  };
}
