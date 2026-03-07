{
  pkgs,
  config,
  containerUtils,
}:
(pkgs.formats.yaml {}).generate "traefik.yaml" {
  api = {
    dashboard = true;
    insecure = true;
  };
  entryPoints = {
    http = {
      address = ":80";
      http.redirections.entryPoint = {
        to = "websecure";
        scheme = "https";
      };
    };
    websecure = {
      address = ":443";
    };
  };
  certificatesResolvers.certresolver.acme = {
    email = "lkjjones1999@gmail.com";
    storage = "/data/acme.json";
    dnsChallenge = {
      provider = "cloudflare";
    };
  };
  providers.docker = {
    exposedByDefault = false; # Best practice to keep this false
    endpoint = "unix:///var/run/docker.sock";
    # file = {
    #   filename = "traefik_dynamic.yml";
    # };
  };
}
