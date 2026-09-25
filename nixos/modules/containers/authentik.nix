{...}: {
  nixos.authentik = {
    lib,
    pkgs,
    config,
    containerUtils,
    ...
  }: let
    cfg = config.modules.nix.containers;
    authentikPath = containerUtils.mkDataPath "authentik";
    secretsFile = "/home/${cfg.mainUser}/secrets/authentik.env";
  in {
    config = {
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
          extraOptions = [
            "--health-cmd=pg_isready -U authentik -d authentik"
            "--health-interval=10s"
            "--health-timeout=5s"
            "--health-retries=5"
            "--health-start-period=20s"
          ];
        };

        authentik-server = {
          image = "ghcr.io/goauthentik/server:2026.8.3";
          cmd = ["server"];
          dependsOn = ["authentik-postgres"];
          networks = ["container:authentik-postgres"];
          environment = {
            AUTHENTIK_POSTGRESQL__HOST = "localhost";
            AUTHENTIK_POSTGRESQL__NAME = "authentik";
            AUTHENTIK_POSTGRESQL__USER = "authentik";
            AUTHENTIK_WEB__BASE_URL = "https://authentik.${cfg.domain}";
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
              "traefik.enable" = "true";
              "traefik.http.routers.${name}.rule" = "Host(`${name}.${cfg.domain}`)";
              "traefik.http.routers.${name}.entrypoints" = "websecure";
              "traefik.http.routers.${name}.tls" = "true";

              "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
              "traefik.http.middlewares.authentik-forward-auth.forwardauth.address" = "http://authentik-server:9000/outpost.goauthentik.io/auth/traefik";
              "traefik.http.middlewares.authentik-forward-auth.forwardauth.trustForwardHeader" = "true";
              "traefik.http.middlewares.authentik-forward-auth.forwardauth.authResponseHeaders" = "X-authentik-username,X-authentik-groups,X-authentik-email,X-authentik-name,X-authentik-uid,X-authentik-jwt,X-authentik-meta-jwks,X-authentik-meta-outpost,X-authentik-meta-provider,X-authentik-meta-app,X-authentik-meta-version";
            };
          };
        };

        authentik-worker = {
          image = "ghcr.io/goauthentik/server:2026.8.3";
          cmd = ["worker"];
          dependsOn = ["authentik-postgres"];
          networks = ["container:authentik-postgres"];
          environment = {
            AUTHENTIK_POSTGRESQL__HOST = "localhost";
            AUTHENTIK_POSTGRESQL__NAME = "authentik";
            AUTHENTIK_POSTGRESQL__USER = "authentik";
            AUTHENTIK_WEB__BASE_URL = "https://authentik.${cfg.domain}";
            AUTHENTIK_LISTEN__HTTP = "0.0.0.0:9100";
            AUTHENTIK_LISTEN__METRICS = "0.0.0.0:9301";
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
  };
}
