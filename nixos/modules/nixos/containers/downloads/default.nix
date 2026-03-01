{
  pkgs,
  config,
  lib,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  dataPaths = {
    qbittorrent = containerUtils.mkDataPath "qbittorent";
    jackett = containerUtils.mkDataPath "jackett";
    sonarr = containerUtils.mkDataPath "sonarr";
    radarr = containerUtils.mkDataPath "radarr";
    prowlarr = containerUtils.mkDataPath "prowlarr";
  };
  storagePaths = containerUtils.storagePaths;
in {
  options.modules.nix.containers.downloads.enable = lib.mkEnableOption "Enable Downloads Containers";
  config = lib.mkIf cfg.downloads.enable {
    systemd.tmpfiles = {
      rules = [
        "d ${dataPaths.qbittorrent} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
        "d ${dataPaths.jackett} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
        "d ${dataPaths.sonarr} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
        "d ${dataPaths.radarr} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      ];
      settings."storage-dirs" = let
        allPaths =
          [
            storagePaths.base
            storagePaths.torrents.dir
            storagePaths.media.dir
          ]
          ++ builtins.attrValues storagePaths.torrents.subdirs
          ++ builtins.attrValues storagePaths.media.subdirs;
      in
        builtins.listToAttrs (map (path: {
            name = path;
            value.d = {
              mode = "0775";
              user = "99";
              group = "100";
            };
          })
          allPaths);
    };
    boot.kernelModules = [
      "iptable_filter"
      "iptable_nat"
      "ip6table_filter"
    ];
    virtualisation.oci-containers.containers = {
      qbittorrent = {
        image = "binhex/arch-qbittorrentvpn:5.1";
        ports = [
          "6881:6881"
          "6881:6881/udp"
          "8118:8118"
          "8120:8080" # Webui
          "9117:9117" # Jackett port
          "8989:8989" # Sonarr port
          "7878:7878" # Radarr port
          "9696:9696" # Prowlarr port
          "8191:8191" # Flaresolverr port
        ];
        volumes = [
          "${dataPaths.qbittorrent}:/config"
          "${storagePaths.torrents.dir}:/storage/torrents"
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
          WEBUI_PORT = "8120";
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
        labels = containerUtils.mkTraefikLabels {
          name = "qbittorrent";
          port = 8120;
        };
      };

      # jackett = {
      #   image = "linuxserver/jackett:0.24.957";
      #   volumes = [
      #     "${dataPaths.jackett}:/config"
      #     "/etc/localtime:/etc/localtime:ro"
      #   ];
      #   environment = {
      #     PUID = "99";
      #     PGID = "100";
      #   };
      #   dependsOn = ["qbittorrent"];
      #   networks = ["container:qbittorrent"];
      #   labels = containerUtils.mkTraefikLabels {
      #     name = "jackett";
      #     port = 9117;
      #   };
      # };

      prowlarr = {
        image = "linuxserver/prowlarr:2.3.0";
        volumes = [
          "${dataPaths.prowlarr}:/config"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
        };
        dependsOn = ["qbittorrent"];
        networks = ["container:qbittorrent"];
        labels = containerUtils.mkTraefikLabels {
          name = "prowlarr";
          port = 9696;
        };
      };

      sonarr = {
        image = "linuxserver/sonarr:4.0.15";
        volumes = [
          "${dataPaths.sonarr}:/config"
          "${storagePaths.base}:/storage"
          # "/dev/rtc:/dev/rtc"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
        };
        dependsOn = ["qbittorrent"];
        networks = ["container:qbittorrent"];
        labels = containerUtils.mkTraefikLabels {
          name = "sonarr";
          port = 8989;
        };
      };

      radarr = {
        image = "binhex/arch-radarr:5.25";
        volumes = [
          "${dataPaths.radarr}:/config"
          "${storagePaths.base}:/storage"
          "/etc/localtime:/etc/localtime:ro"
        ];
        environment = {
          PUID = "99";
          PGID = "100";
          UMASK = "000";
        };
        dependsOn = ["qbittorrent"];
        networks = ["container:qbittorrent"];
        labels = containerUtils.mkTraefikLabels {
          name = "radarr";
          port = 7878;
        };
      };

      flaresolverr = {
        image = "ghcr.io/flaresolverr/flaresolverr:v3.4.6";
        dependsOn = ["qbittorrent"];
        networks = ["container:qbittorrent"];
        # labels = containerUtils.mkTraefikLabels {
        #   name = "flaresolverr";
        #   port = 8191;
        # };
      };
    };
  };
}
