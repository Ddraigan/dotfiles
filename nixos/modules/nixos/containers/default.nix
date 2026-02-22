{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.nix.containers;
in {
  imports = [
    ./traefik
    ./homeass
    ./cfddns
    ./uptime-kuma
    ./jellyfin
  ];
  options.modules.nix.containers = with lib; {
    domain = mkOption {
      type = types.str;
      description = "Base domain used for Traefik-routed services.";
    };

    mainUser = mkOption {
      type = types.str;
      description = "Primary user that owns container data directories.";
    };

    dataPath = mkOption {
      type = types.path;
      default = "/home/${config.modules.nix.containers.mainUser}/appdata";
      description = "Base path for container persistent data.";
    };
  };

  config._module.args.containerUtils = {
    mkTraefikLabels = {
      name,
      port,
      extraLabels ? {},
    }:
      lib.mkMerge [
        {
          "traefik.enable" = "true";
          "traefik.http.routers.${name}.rule" = "Host(`${name}.${cfg.domain}`)";
          "traefik.http.routers.${name}.entrypoints" = "websecure";
          "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
          "traefik.http.routers.${name}.tls" = "true";
        }
        extraLabels
      ];
  };
}
