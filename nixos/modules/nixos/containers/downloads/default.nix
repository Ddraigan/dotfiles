{
  pkgs,
  config,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  qbittorrentPath = containerUtils.mkDataPath "qbittorent";
  jackettPath = containerUtils.mkDataPath "jackett";
  sonarrPath = containerUtils.mkDataPath "sonarr";
  radarrPath = containerUtils.mkDataPath "radarr";
  mediaPath = "/home/leon/media/qbittorent";
in {
  options.modules.nix.containers.downloads.enable = lib.mkEnableOption "Enable Downloads Containers";
  config = lib.mkIf cfg.downloads.enable {
    systemd.tmpfiles.rules = [
      "d ${qbittorrentPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${jackettPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${sonarrPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${radarrPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${mediaPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
    ];
    virtualisation.oci-containers.containers = {
      qbittorrent = {
        image = "binhex/arch-qbittorrentvpn:5.1";
        ports = [
          "6881:6881"
          "6881:6881/udp"
          "8118:8118"
          "8081:8080" # Webui
          "9117:9117" # Jackett port
          "8989:8989" # Sonarr port
          "7878:7878" # Radarr port
          "8191:8191" # Flaresolverr port
        ];
        volumes = [
          "${qbittorrentPath}:/config"
          "${mediaPath}:/downloads"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environmentFiles = [
          "/home/leon/secrets/qbittorrent.env"
        ];
        environment = {
          VPN_ENABLED = "yes";
          # VPN_USER = ""; In secrets env file
          # VPN_PASS = ""; In secrets env file
          VPN_PROV = "pia";
          VPN_CLIENT = "openvpn";
          STRICT_PORT_FORWARD = "no";
          ENABLE_PRIVOXY = "yes";
          WEBUI_PORT = "8081";
          LAN_NETWORK = "192.168.1.0/24";
          NAME_SERVERS = "209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1";
          VPN_INPUT_PORTS = "9117,8989,7878";
          VPN_OUTPUT_PORTS = "9117,8989,7878";
          UMASK = "000";
          PUID = "99";
          PGID = "100";
        };
        capabilities = {
          net_admin = true;
        };
      };

      # jackett = {
      #   image = "linuxserver/jackett:0.24.957";
      #   volumes = [
      #     "${jackettPath}:/config"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   environment = {
      #     PUID = "99";
      #     PGID = "100";
      #   };
      #   dependsOn = ["qbittorrent"];
      #   networks = ["container:qbittorrent"];
      # };
      #
      # sonarr = {
      #   image = "linuxserver/sonarr:4.0.15";
      #   volumes = [
      #     "${sonarrPath}:/config"
      #     "${mediaPath}/completed:/downloads"
      #     "/mnt/fern/plex:/tv"
      #     "/dev/rtc:/dev/rtc"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   environment = {
      #     PUID = "99";
      #     PGID = "100";
      #   };
      #   dependsOn = ["qbittorrent"];
      #   networks = ["container:qbittorrent"];
      # };
      #
      # radarr = {
      #   image = "binhex/arch-radarr:5.25";
      #   volumes = [
      #     "${radarrPath}:/config"
      #     "${mediaPath}:/data"
      #     "/mnt/fern/plex:/media"
      #   ];
      #   environment = {
      #     PUID = "99";
      #     PGID = "100";
      #     UMASK = "000";
      #   };
      #   dependsOn = ["qbittorrent"];
      #   networks = ["container:qbittorrent"];
      # };
      #
      # flaresolverr = {
      #   image = "ghcr.io/flaresolverr/flaresolverr:v3.4.6";
      #   dependsOn = ["qbittorrent"];
      #   networks = ["container:qbittorrent"];
      # };
    };
  };
}
