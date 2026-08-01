{
  config,
  lib,
  pkgs,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  headscalePath = "${cfg.dataPath}/headscale";
  headplanePath = "${cfg.dataPath}/headplane";
  headscaleConfig = pkgs.writeText "headscale-config.yaml" ''
    server_url: http://127.0.0.1:8080
    listen_addr: 0.0.0.0:8080
    metrics_addr: 127.0.0.1:9090

    noise:
      private_key_path: /var/lib/headscale/noise_private.key

    prefixes:
      v4: 100.64.0.0/10
      v6: fd7a:115c:a1e0::/48

    database:
      type: sqlite3
      sqlite:
        path: /var/lib/headscale/db.sqlite

    base_domain: tailnet.local

    dns:
      magic_dns: true
      base_domain: tailnet.local
      override_local_dns: true
      nameservers:
        global:
          - 1.1.1.1
          - 8.8.8.8

    derp:
      server:
        enabled: false
      urls:
        - https://controlplane.tailscale.com/derpmap/default
  '';
in {
  options.modules.nix.containers.headscale.enable = lib.mkEnableOption "Enable Headscale and Headplane Containers";

  config = lib.mkIf cfg.headscale.enable {
    networking.firewall = {
      allowedTCPPorts = [3543];
      allowedUDPPorts = [3543];
    };
    systemd.tmpfiles.rules = [
      "d ${headscalePath}/config 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${headscalePath}/lib 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${headplanePath}/config 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${headplanePath}/lib 0755 ${cfg.mainUser} ${cfg.mainUser} -"
    ];
    virtualisation.oci-containers.containers = {
      headplane = {
        image = "ghcr.io/tale/headplane:latest";
        autoStart = true;
        volumes = [
          "${headplanePath}/config:/etc/headplane"
          "${headplanePath}/lib:/var/lib/headplane"
          # "${headscalePath}:/etc/headscale/config.yaml"
          # "${headscalePath}:/etc/headscale/dns_records.json"
          "/var/run/docker.sock:/var/run/docker.sock:ro"
        ];
        environment = {
          TZ = config.time.timeZone;
        };
        labels = let
          name = "headplane";
          port = 3000;
        in {
          "traefik.enable" = "true";
          "traefik.http.routers.headplane.rule" = "Host(`headscale.${cfg.domain}`) && PathPrefix(`/admin`)";
          "traefik.http.routers.${name}.entrypoints" = "websecure";
          "traefik.http.routers.${name}.tls" = "true";

          "traefik.http.services.${name}.loadbalancer.server.port" = toString port;
        };
      };

      headscale = {
        image = "headscale/headscale:0.26.0";
        autoStart = true;
        cmd = ["serve"];
        ports = ["3543:3543"];
        volumes = [
          "${headscalePath}/config:/etc/headscale"
          "${headscalePath}/lib:/var/lib/headscale"
        ];
        environment = {
          TZ = config.time.timeZone;
        };
        labels = let
          name = "headscale";
        in
          containerUtils.mkTraefikLabels {
            name = name;
            port = 3543;
            extraLabels = {
              "me.tale.headplane.target" = "headscale";
              "traefik.http.routers.headscale.rule" = "Host(`headscale.${cfg.domain}`)";

              # CORS Middleware
              "traefik.http.routers.headscale.middlewares" = "cors";
              "traefik.http.middlewares.cors.headers.accesscontrolallowheaders" = "*";
              "traefik.http.middlewares.cors.headers.accesscontrolallowmethods" = "GET,POST,PUT";
              "traefik.http.middlewares.cors.headers.accesscontrolalloworiginlist" = "https://headscale.${cfg.domain}";
              "traefik.http.middlewares.cors.headers.accesscontrolmaxage" = "100";
              "traefik.http.middlewares.cors.headers.addvaryheader" = "true";

              # Root to /admin redirect (rewrite)
              "traefik.http.routers.rewrite.rule" = "Host(`headscale.${cfg.domain}`) && Path(`/`)";
              "traefik.http.routers.rewrite.service" = "headscale";
              "traefik.http.routers.rewrite.middlewares" = "rewrite";
              "traefik.http.middlewares.rewrite.addprefix.prefix" = "/admin";
            };
          };
      };
    };
  };
}
