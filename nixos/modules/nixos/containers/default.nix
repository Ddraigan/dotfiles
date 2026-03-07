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
    ./downloads
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

          "traefik.http.routers.${name}.tls" = "true";
          "traefik.http.routers.${name}.tls.certresolver" = "certresolver";
          "traefik.http.routers.${name}.tls.domains[0].main" = "${cfg.domain}";
          "traefik.http.routers.${name}.tls.domains[0].sans" = "*.${cfg.domain}";

          "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
        }
        extraLabels
      ];
    mkDataPath = name: "${cfg.dataPath}/${name}";
    storagePaths = rec {
      base = "/storage";
      torrents = rec {
        dir = "${base}/torrents";
        subdirs = {
          books = "${dir}/books";
          movies = "${dir}/movies";
          music = "${dir}/music";
          tv = "${dir}/tv";
        };
      };
      media = rec {
        dir = "${base}/media";
        subdirs = {
          books = "${dir}/books";
          movies = "${dir}/movies";
          music = "${dir}/music";
          tv = "${dir}/tv";
        };
      };
    };
  };
}
