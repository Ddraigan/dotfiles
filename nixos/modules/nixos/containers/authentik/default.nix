{
  config,
  lib,
  pkgs,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  authentikPath = containerUtils.mkDataPath "authentik";
  secretsFile = "/home/${cfg.mainUser}/secrets/authentik.env";
in {
  options.modules.nix.containers.authentik.enable = lib.mkEnableOption "Enable Authentik";

  config = lib.mkIf cfg.authentik.enable {
    systemd.tmpfiles.rules = [
      "d ${authentikPath} 0755 ${cfg.mainUser} users -"
      "d ${authentikPath}/postgres 0755 ${cfg.mainUser} users -"
      "d ${authentikPath}/data 0755 ${cfg.mainUser} users -"
      "d ${authentikPath}/certs 0755 ${cfg.mainUser} users -"
      "d ${authentikPath}/custom-templates 0755 ${cfg.mainUser} users -"
    ];

    virtualisation.oci-containers.containers = {
      authentik-postgres = {
        image = "docker.io/library/postgres:16-alpine";
        environment = {
          POSTGRES_DB = "authentik";
          POSTGRES_USER = "authentik";
        };
        environmentFiles = [secretsFile];
        volumes = [
          "${authentikPath}/postgres:/var/lib/postgresql/data"
        ];
      };

      authentik-server = {
        image = "ghcr.io/goauthentik/server:2026.8.2";
        cmd = ["server"];
        dependsOn = ["authentik-postgres"];
        networks = ["container:authentik-postgres"];
        environment = {
          AUTHENTIK_POSTGRESQL__HOST = "localhost";
          AUTHENTIK_POSTGRESQL__NAME = "authentik";
          AUTHENTIK_POSTGRESQL__USER = "authentik";
          TZ = config.time.timeZone;
        };
        environmentFiles = [secretsFile];
        extraOptions = [
          "--shm-size=512mb"
        ];
        volumes = [
          "${authentikPath}/data:/data"
          "${authentikPath}/custom-templates:/templates"
        ];
        labels = containerUtils.mkTraefikLabels {
          name = "authentik";
          port = 9000;
          extraLabels = {
            "traefik.http.middlewares.authentik-headers.headers.customrequestheaders.X-Forwarded-Proto" = "https";
            "traefik.http.routers.authentik.middlewares" = "authentik-headers";
          };
        };
      };

      authentik-worker = {
        image = "ghcr.io/goauthentik/server:2026.8.2";
        cmd = ["worker"];
        dependsOn = ["authentik-postgres"];
        networks = ["container:authentik-postgres"];
        environment = {
          AUTHENTIK_POSTGRESQL__HOST = "localhost";
          AUTHENTIK_POSTGRESQL__NAME = "authentik";
          AUTHENTIK_POSTGRESQL__USER = "authentik";
          TZ = config.time.timeZone;
        };
        environmentFiles = [secretsFile];
        extraOptions = [
          "--shm-size=512mb"
        ];
        user = "root";
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "${authentikPath}/data:/data"
          "${authentikPath}/certs:/certs"
          "${authentikPath}/custom-templates:/templates"
        ];
      };
    };
  };
}