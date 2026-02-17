{
  config,
  pgks,
  lib,
  ...
}: let
  cfg = config.modules.nix.containers.traefik;
in {
  options.modules.nix.containers.traefik.enable = lib.mkEnableOption "Enable Traefik";
  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.containers = {
      traefik = {
        image = "traefik:latest";
        autoStart = true;
        ports = [
          "80:80"
          "443:443"
        ];
        volumes = [
          "/etc/localtime:/etc/localtime:ro"
          "/var/run/docker.sock:/var/run/docker.sock:ro"
          "/etc/traefik/traefik.yml:/traefik.yml:ro"
          "/etc/traefik_dynamic.yml:/traefik_dynamic.yml:ro"
          "/srv/traefik/acme.json:/acme.json"
        ];
        environment = {
          CF_API_EMAIL = "";
          CF_API_TOKEN = "";
        };
        # environmentFiles = [
        #   "/run/secrets/traefik.env"
        # ];
        labels = {
          "traefik.enable" = "true";
          "traefik.http.routers.api.entrypoints" = "https";
          "traefik.http.routers.api.rule" = "Host(`traefik.ddraigan.com`)";
          "traefik.http.routers.api.service" = "api@internal";
        };
        extraOptions = [
          "--network=traefikProxy"
          # "--restart=unless-stopped"
          "--security-opt=no-new-privileges:true"
          "--name=traefik"
        ];
      };
    };
  };
}
