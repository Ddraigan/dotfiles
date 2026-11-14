{...}: {
  nixos.mealie = {
    lib,
    pkgs,
    config,
    containerUtils,
    ...
  }: let
    cfg = config.modules.nix.containers;
    mealiePath = containerUtils.mkDataPath "mealie";
  in {
    config = {
      systemd.tmpfiles.rules = [
        "d ${mealiePath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      ];

      virtualisation.oci-containers.containers.mealie = {
        image = "ghcr.io/mealie-recipes/mealie:v3.31.0";
        autoStart = true;
        environment = {
          TZ = config.time.timeZone;
          BASE_URL = "https://mealie.${cfg.domain}";
          ALLOW_SIGNUP = "false";
          DB_ENGINE = "sqlite";
          OIDC_AUTH_ENABLED = "true";
        };
        volumes = [
          "${mealiePath}:/app/data"
        ];
        labels = containerUtils.mkTraefikLabelsWithAuth {
          name = "mealie";
          port = 9000;
          forwardAuth = false;
        };
      };
    };
  };
}
