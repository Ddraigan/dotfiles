{
  config,
  lib,
  pkgs,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  traefikPath = "${cfg.dataPath}/traefik";
in {
  options.modules.nix.containers.traefik.enable = lib.mkEnableOption "Enable Traefik";
  config = lib.mkIf cfg.traefik.enable {
    networking.firewall.allowedTCPPorts = [443 80];
    systemd.tmpfiles.rules = [
      "d ${traefikPath} 0755 ${cfg.mainUser} users -"
      "Z ${traefikPath} - ${cfg.mainUser} users -"
      "f ${traefikPath}/acme.json 0600 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers = {
      containers = {
        traefik = {
          image = "traefik:v3.6";
          ports = [
            "80:80"
            "443:443"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "${traefikPath}:/data"
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
}
