{...}: {
  nixos.containers = {
    lib,
    pkgs,
    config,
    ...
  }: let
    cfg = config.modules.nix.containers;
  in {
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

            "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
          }
          extraLabels
        ];
      mkTraefikLabelsWithAuth = {
        name,
        port,
        extraMiddlewares ? [],
        extraLabels ? {},
        authBypassRoutes ? [],
      }: let
        bypassName = route: lib.replaceStrings ["/"] ["-"] (lib.removeSuffix "/" (lib.removePrefix "/" route));
      in
        lib.mkMerge ([
            {
              "traefik.enable" = "true";

              "traefik.http.routers.${name}.rule" = "Host(`${name}.${cfg.domain}`)";
              "traefik.http.routers.${name}.entrypoints" = "websecure";
              "traefik.http.routers.${name}.tls" = "true";
              "traefik.http.routers.${name}.priority" = "10";
              "traefik.http.routers.${name}.middlewares" = lib.concatStringsSep "," (
                ["authentik-forward-auth@docker"] ++ extraMiddlewares
              );
              "traefik.http.routers.${name}.service" = "${name}@docker";

              "traefik.http.routers.${name}-outpost.rule" = "Host(`${name}.${cfg.domain}`) && PathPrefix(`/outpost.goauthentik.io/`)";
              "traefik.http.routers.${name}-outpost.entrypoints" = "websecure";
              "traefik.http.routers.${name}-outpost.tls" = "true";
              "traefik.http.routers.${name}-outpost.priority" = "15";
              "traefik.http.routers.${name}-outpost.service" = "authentik@docker";

              "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
            }
            extraLabels
          ]
          ++ lib.imap0 (i: route: {
            "traefik.http.routers.${name}-${bypassName route}.rule" = "Host(`${name}.${cfg.domain}`) && PathPrefix(`${route}`)";
            "traefik.http.routers.${name}-${bypassName route}.entrypoints" = "websecure";
            "traefik.http.routers.${name}-${bypassName route}.tls" = "true";
            "traefik.http.routers.${name}-${bypassName route}.priority" = toString (20 + i);
            "traefik.http.routers.${name}-${bypassName route}.service" = "${name}@docker";
          })
          authBypassRoutes);

      mkDataPath = name: "${cfg.dataPath}/${name}";
      storagePaths = rec {
        # base = "/storage";
        base = "/mnt/isa/media";
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
  };
}
