{...}: {
  nixos.tandoor = {
    lib,
    pkgs,
    config,
    containerUtils,
    ...
  }: let
    cfg = config.modules.nix.containers;
    tandoorPath = containerUtils.mkDataPath "tandoor";
    dbPath = "${tandoorPath}/postgres";
    secretsFile = "/home/${cfg.mainUser}/secrets/tandoor.env";
  in {
    config = {
      systemd.tmpfiles.rules = [
        "d ${tandoorPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
        "d ${dbPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      ];

      virtualisation.oci-containers.containers = {
        tandoor-db = {
          image = "postgres:15-alpine";
          autoStart = true;
          environment = {
            POSTGRES_DB = "tandoor";
            POSTGRES_USER = "tandoor";
          };
          environmentFiles = [secretsFile];
          volumes = [
            "${dbPath}:/var/lib/postgresql/data"
          ];
        };

        tandoor = {
          image = "vabene1111/recipes";
          autoStart = true;
          dependsOn = ["tandoor-db"];
          environment = {
            TZ = config.time.timeZone;
            DB_ENGINE = "django.db.backends.postgresql";
            POSTGRES_HOST = "tandoor-db";
            POSTGRES_DB = "tandoor";
            POSTGRES_USER = "tandoor";
          };
          environmentFiles = [secretsFile];
          volumes = [
            "${tandoorPath}:/opt/recipes/mediafiles"
          ];
          labels = containerUtils.mkTraefikLabelsWithAuth {
            name = "tandoor";
            port = 80;
          };
        };
      };
    };
  };
}
