{
  config,
  pkgs,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  containerName = "jellyfin";
  jellyPath = "${cfg.dataPath}/${containerName}";
in {
  options.modules.nix.containers.jellyfin.enable = lib.mkEnableOption "Enable Jellyfin";
  config = lib.mkIf cfg.jellyfin.enable {
    systemd.tmpfiles.rules = [
      "d ${jellyPath} 0755 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers.containers = {
      ${containerName} = {
        image = "jellyfin/jellyfin";
        autoStart = true;
        volumes = [
          "${jellyPath}/config:/config"
          "${jellyPath}/cache:/cache"
          "${jellyPath}/log:/log"
          "/media/Movies:/movies"
          "/media/TV-Series:/tv"
        ];
        environment = {
          JELLYFIN_LOG_DIR = "/log";
        };
        labels = containerUtils.mkTraefikLabels {
          name = containerName;
          port = 8096;
        };
      };
    };
  };
}
