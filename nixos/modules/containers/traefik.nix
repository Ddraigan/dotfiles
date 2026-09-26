{...}: {
  nixos.traefik =
    {
      lib,
      pkgs,
      config,
      containerUtils,
      ...
    }:
    let
      cfg = config.modules.nix.containers;
      traefikPath = "${cfg.dataPath}/traefik";
  traefikDynamicConfig = pkgs.writeText "traefik-dynamic.yml" 
    #yaml
    ''
    http:
      routers:
        truenas:
          rule: "Host(`isa.${cfg.domain}`)"
          entryPoints:
            - "websecure"
          service: "truenas-service"
          tls:
            certResolver: "certresolver"
        wireguard:
          rule: "Host(`wg.${cfg.domain}`)"
          entryPoints:
            - "websecure"
          service: "wireguard-service"
          tls:
            certResolver: "certresolver"
      services:
        truenas-service:
          loadBalancer:
            servers:
              - url: "http://10.69.1.21:80"
        wireguard-service:
          loadBalancer:
            servers:
              - url: "http://10.69.1.11:51821"
      '';
    in {
      config = {
    networking.firewall.allowedTCPPorts = [443 80];
    systemd.tmpfiles.rules = [
      "d ${traefikPath} 0755 ${cfg.mainUser} users -"
      "Z ${traefikPath} - ${cfg.mainUser} users -"
      "f ${traefikPath}/acme.json 0600 ${cfg.mainUser} users -"
    ];

    systemd.services."docker-network-proxy" = {
      description = "Create the proxy docker network";
      wantedBy = ["multi-user.target"];
      after = ["docker.service"];
      before = [
        "docker-traefik.service"
        "docker-authentik-postgres.service"
        "docker-authentik-server.service"
        "docker-authentik-worker.service"
      ];
      path = [config.virtualisation.docker.package];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        docker network inspect proxy >/dev/null 2>&1 \
          || docker network create --driver bridge proxy
      '';
    };

    systemd.services."docker-traefik" = {
      after = [ "docker-network-proxy.service" ];
      requires = [ "docker-network-proxy.service" ];
      postStart = ''
        for _ in $(seq 1 60); do
          if ${config.virtualisation.docker.package}/bin/docker container inspect traefik >/dev/null 2>&1; then
            ${config.virtualisation.docker.package}/bin/docker network connect bridge traefik
            exit 0
          fi
          sleep 0.5
        done
        echo "docker-traefik: container never appeared, cannot attach bridge network" >&2
        exit 1
      '';
    };

    virtualisation.oci-containers = {
      containers = {
        traefik = {
          image = "traefik:v3.6";
          networks = ["proxy"];
          ports = [
            "80:80"
            "443:443"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "${traefikPath}:/data"
            "${traefikDynamicConfig}:/dynamic.yml:ro"
            # "${import ./traefikconf.nix {inherit pkgs config containerUtils;}}:/etc/traefik/traefik.yaml:ro"
          ];
          environmentFiles = [
            "/home/leon/secrets/traefik.env"
          ];
          labels = {
            "traefik.enable" = "true";

            # Dashboard Router
            "traefik.http.routers.traefik-dashboard.rule" = "Host(`traefik.${cfg.domain}`)";
            "traefik.http.routers.traefik-dashboard.entrypoints" = "websecure";
            "traefik.http.routers.traefik-dashboard.service" = "api@internal";

            # SSL Wildcard Config
            "traefik.http.routers.traefik-dashboard.tls" = "true";
            "traefik.http.routers.traefik-dashboard.tls.certresolver" = "certresolver";
            "traefik.http.routers.traefik-dashboard.tls.domains[0].main" = "${cfg.domain}";
            "traefik.http.routers.traefik-dashboard.tls.domains[0].sans" = "*.${cfg.domain}";
          };
          cmd = [
            "--api.dashboard=true"
            "--providers.docker=true"
            # only pick up containers that opt in with traefik.enable=true
            "--providers.docker.exposedByDefault=false"

            # Dynamic configs
            "--providers.file.filename=/dynamic.yml"
            "--providers.file.watch=true"

            "--entrypoints.web.address=:80"
            "--entrypoints.web.http.redirections.entrypoint.to=websecure"
            "--entrypoints.web.http.redirections.entrypoint.scheme=https"
            "--entrypoints.websecure.address=:443"

            "--certificatesresolvers.certresolver.acme.email=lkjjones1999@gmail.com"
            "--certificatesresolvers.certresolver.acme.storage=/data/acme.json"
            "--certificatesresolvers.certresolver.acme.dnschallenge=true"
            "--certificatesresolvers.certresolver.acme.dnschallenge.provider=cloudflare"
          ];
        };
      };
    };
  };
};
}
