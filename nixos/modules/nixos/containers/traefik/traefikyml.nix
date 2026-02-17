{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.nix.containers.traefik;
  yaml = pkgs.formats.yaml {};
in {
  config ={
    environment.etc."traefik/traefik.yml".source = yaml.generate "traefik.yml" {
      api.dashboard = true;

      entryPoints = {
        http = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "https";
            scheme = "https";
            permanent = true;
          };
        };

        https = {
          address = ":443";
          http.tls = {
            certResolver = "cloudflare";
            domains = [
              {
                main = "ddraigan.com";
                sans = ["*.ddraigan.com"];
              }
            ];
          };
        };
      };

      certificatesResolvers.cloudflare.acme = {
        storage = "acme.json";
        dnsChallenge = {
          provider = "cloudflare";
          delayBeforeCheck = 90;
          disablePropagationCheck = true;
          resolvers = [
            "1.1.1.1:53"
            "1.0.0.1:53"
          ];
        };
      };

      providers = {
        docker = {
          watch = true;
          network = "traefikProxy";
          exposedByDefault = false;
          endpoint = "unix:///var/run/docker.sock";
        };

        # file = {
        #   filename = "traefik_dynamic.yml";
        # };
      };
    };
  };
}
