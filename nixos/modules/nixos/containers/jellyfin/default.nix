{
  config,
  pkgs,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  jellyPath = containerUtils.mkDataPath "jellyfin";
  seerrPath = containerUtils.mkDataPath "seerr";
  mediaPaths = containerUtils.storagePaths.media;
in {
  options.modules.nix.containers.jellyfin.enable = lib.mkEnableOption "Enable Jellyfin";
  config = lib.mkIf cfg.jellyfin.enable {
    systemd.tmpfiles.rules = [
      "d ${jellyPath} 0755 ${cfg.mainUser} users -"
      "d ${seerrPath} 0755 ${cfg.mainUser} users -"
    ];
    virtualisation.oci-containers.containers = {
      jellyfin = {
        image = "jellyfin/jellyfin";
        autoStart = true;
        volumes = [
          "${jellyPath}/config:/config"
          "${jellyPath}/cache:/cache"
          "${jellyPath}/log:/log"
          "${mediaPaths.subdirs.books}:/storage/media/books"
          "${mediaPaths.subdirs.movies}:/storage/media/movies"
          "${mediaPaths.subdirs.music}:/storage/media/music"
          "${mediaPaths.subdirs.tv}:/storage/media/tv"
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
      seerr = {
        image = "ghcr.io/seerr-team/seerr:latest";
        autoStart = true;
        volumes = [
          "${seerrPath}:/app/config"
        ];
        environment = {
          LOG_LEVEL = "debug";
          PORT = "5055";
          PUID = "99";
          PGID = "100";
        };
        labels = containerUtils.mkTraefikLabels {
          name = "seerr";
          port = 5055;
        };
      };
    };
  };
}
