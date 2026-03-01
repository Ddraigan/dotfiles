{
  config,
  pkgs,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  jellyPath = containerUtils.mkDataPath "jellyfin";
  mediaPaths = containerUtils.storagePaths.media;
in {
  options.modules.nix.containers.jellyfin.enable = lib.mkEnableOption "Enable Jellyfin";
  config = lib.mkIf cfg.jellyfin.enable {
    systemd.tmpfiles.rules = [
      "d ${jellyPath} 0755 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers.containers = {
      jellyfin = {
        image = "jellyfin/jellyfin";
        autoStart = true;
        volumes = [
          "${jellyPath}/config:/config"
          "${jellyPath}/cache:/cache"
          "${jellyPath}/log:/log"
          "${mediaPaths.subdirs.books}:/books"
          "${mediaPaths.subdirs.movies}:/movies"
          "${mediaPaths.subdirs.music}:/music"
          "${mediaPaths.subdirs.tv}:/tv"
        ];
        environment = {
          JELLYFIN_LOG_DIR = "/log";
          PUID = "99";
          PGID = "100";
        };
        labels = containerUtils.mkTraefikLabels {
          name = "jellyfin";
          port = 8096;
        };
      };
    };
  };
}
