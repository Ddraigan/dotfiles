{
  config,
  pgks,
  lib,
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

      "d ${traefikPath} 0755 ${cfg.mainUser} users -"
      "f ${traefikPath}/acme.json 0600 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers = {
      containers = {
        traefik = {
          image = "traefik:v3.6";
          ports = [
            "80:80"
            "443:443"
            "8080:8080"
          ];
          volumes = [
            "/var/run/docker.sock:/var/run/docker.sock"
            "${traefikPath}:/data"
          ];
          environmentFiles = [
            "/home/leon/secrets/traefik.env"
          ];
          labels = containerUtils.mkTraefikLabels {
            name = "traefik";
            port = 8080;
            enableTls = false;
            extraLabels = {
              "traefik.http.routers.dashboard.tls.domains[0].main" = "ddraigan.com";
              "traefik.http.routers.dashboard.tls.domains[0].sans" = "*.ddraigan.com";
              "traefik.http.routers.dashboard.tls.certresolver" = "certresolver";
            };
          };
          cmd = [
            "--api.insecure=true"
            "--providers.docker=true"
            "--entrypoints.web.address=:80"
            "--entrypoints.websecure.address=:443"
            "--certificatesresolvers.certresolver.acme.email=lkjjones1999@gmail.com"
            "--certificatesresolvers.certresolver.acme.storage=/data/acme.json"
            "--certificatesresolvers.certresolver.acme.dnschallenge=true"
            "--certificatesresolvers.certresolver.acme.dnschallenge.provider=cloudflare"
            "--entrypoints.web.http.redirections.entrypoint.to=websecure"
            "--entrypoints.web.http.redirections.entrypoint.scheme=https"
          ];
        };
      };
    };
  };
}
