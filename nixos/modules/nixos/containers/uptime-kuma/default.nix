{
  config,
  pgks,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  kumaPath = "${cfg.dataPath}/uptime-kuma";
in {
  options.modules.nix.containers.traefik.enable = lib.mkEnableOption "Enable Traefik";
  config = lib.mkIf cfg.traefik.enable {
    networking.firewall.allowedTCPPorts = [443 80];
    systemd.tmpfiles.rules = [
      "d ${kumaPath} 0755 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers = {
      containers = {
        uptime-kuma = {
          image = "louislam/uptime-kuma:2.1.1";
          volumes = [
            "${kumaPath}:/app/data"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];
          labels = containerUtils.mkTraefikLabels {
            name = "uptime-kuma";
            port = 3001;
            extraLabels = {
              # WebSocket support
              "traefik.http.middlewares.uptime-kuma-headers.headers.customrequestheaders.X-Forwarded-Proto" = "https";
              "traefik.http.routers.uptime-kuma.middlewares" = "uptime-kuma-headers";
            };
          };
        };
      };
    };
  };
}
