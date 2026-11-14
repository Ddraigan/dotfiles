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
    network = "tandoor";
  in {
    config = {
      systemd.tmpfiles.rules = [
        "d ${tandoorPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
        "d ${dbPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      ];

      systemd.services."docker-network-${network}" = {
        description = "Create the ${network} docker network";
        wantedBy = ["multi-user.target"];
        after = ["docker.service"];
        before = [
          "docker-tandoor-db.service"
          "docker-tandoor.service"
        ];
        path = [config.virtualisation.docker.package];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          docker network inspect ${network} >/dev/null 2>&1 \
            || docker network create --driver bridge ${network}
        '';
      };

      systemd.services."docker-tandoor".postStart = ''
        for _ in $(seq 1 60); do
          if ${config.virtualisation.docker.package}/bin/docker container inspect tandoor >/dev/null 2>&1; then
            ${config.virtualisation.docker.package}/bin/docker network connect bridge tandoor 2>/dev/null || true
            exit 0
          fi
          sleep 0.5
        done
        echo "docker-tandoor: container never appeared, cannot attach bridge network" >&2
        exit 1
      '';

      virtualisation.oci-containers.containers = {
        tandoor-db = {
          image = "postgres:15-alpine";
          autoStart = true;
          networks = [network];
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
          networks = [network "proxy"];
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
            extraLabels = {
              "traefik.docker.network" = "proxy";
            };
          };
        };
      };
    };
  };
}
