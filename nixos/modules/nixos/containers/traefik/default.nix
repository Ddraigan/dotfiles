{
  config,
  pgks,
  lib,
  ...
}: let
  cfg = config.modules.nix.containers;
  traefikPath = cfg.mkPath "traefik";
  kumaPath = cfg.mkPath "uptime-kuma";
in {
  options.modules.nix.containers.traefik.enable = lib.mkEnableOption "Enable Traefik";
  config = lib.mkIf cfg.traefik.enable {
    networking.firewall.allowedTCPPorts = [443 80];
    systemd.tmpfiles.rules = [
      "d ${traefikPath} 0755 ${cfg.mainUser} users -"
      "Z ${traefikPath} - ${cfg.mainUser} users -"

      "d ${kumaPath} 0755 ${cfg.mainUser} users -"

      "d ${traefikPath} 0755 ${cfg.mainUser} users -"
      "f ${traefikPath}/acme.json 0600 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers = {
      containers = {
        uptime-kuma = {
          image = "louislam/uptime-kuma:2.1.1";
          volumes = [
            "${kumaPath}:/app/data"
          ];
          labels = {
            "traefik.enable" = "true";
            "traefik.http.routers.uptime-kuma.rule" = "Host(\`uptime-kuma.${cfg.domain}\`)";
            "traefik.http.services.uptime-kuma.loadbalancer.server.port" = "3001";
            "traefik.http.routers.uptime-kuma.entrypoints" = "websecure";
            "traefik.http.routers.uptime-kuma.tls.certresolver" = "certresolver";
            # WebSocket support
            "traefik.http.middlewares.uptime-kuma-headers.headers.customrequestheaders.X-Forwarded-Proto" = "https";
            "traefik.http.routers.uptime-kuma.middlewares" = "uptime-kuma-headers";
          };
        };
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
          cmd = [
            "--api.insecure=true"
            "--providers.docker=true"
            "--entrypoints.web.address=:80"
            "--entrypoints.websecure.address=:443"
            # "--certificatesresolvers.certresolver.acme.email=CF_API_EMAIL"
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
# virtualisation.oci-containers.containers = {
#   traefik = {
#     image = "traefik:latest";
#     autoStart = true;
#     ports = [
#       "80:80"
#       "443:443"
#     ];
#     volumes = [
#       "/etc/localtime:/etc/localtime:ro"
#       "/var/run/docker.sock:/var/run/docker.sock:ro"
#       "/etc/traefik/traefik.yml:/traefik.yml:ro"
#       "/etc/traefik_dynamic.yml:/traefik_dynamic.yml:ro"
#       "/srv/traefik/acme.json:/acme.json"
#     ];
#     environment = {
#       CF_API_EMAIL = "";
#       CF_API_TOKEN = "";
#     };
#     # environmentFiles = [
#     #   "/run/secrets/traefik.env"
#     # ];
#     labels = {
#       "traefik.enable" = "true";
#       "traefik.http.routers.api.entrypoints" = "https";
#       "traefik.http.routers.api.rule" = "Host(`traefik.ddraigan.com`)";
#       "traefik.http.routers.api.service" = "api@internal";
#     };
#     extraOptions = [
#       "--network=traefikProxy"
#       # "--restart=unless-stopped"
#       "--security-opt=no-new-privileges:true"
#       "--name=traefik"
#     ];
#   };
# };

