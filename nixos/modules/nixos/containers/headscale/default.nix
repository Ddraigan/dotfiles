{
  config,
  lib,
  pkgs,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  headscalePath = "${cfg.dataPath}/headscale";
  headscaleConfig =
    pkgs.writeText "headscale-config.yaml"
    #yaml
    ''
      server_url: http://${cfg.domain}:8080

      listen_addr: 0.0.0.0:8080
      metrics_listen_addr: 127.0.0.1:9090

      ip_prefixes:
        - 100.64.0.0/10
        - fd7a:115c:a1e0::/48

      db_type: sqlite3
      db_path: /var/lib/headscale/db.sqlite

      derp:
        server:
          enabled: true
          region_id: 999
          region_code: "headscale"
          region_name: "Headscale Embedded DERP"
          # This handles NAT traversal over UDP, similar to WireGuard
          stun_listen_addr: "0.0.0.0:3478"
        urls:
          - https://tailscale.com

      dns:
        magic_dns: true
        base_domain: ${cfg.domain}
        nameservers:
          - 192.168.1.22
          # - 1.1.1.1

      tls_letsencrypt_hostname: ""
      tls_letsencrypt_cache_dir: ""
      tls_letsencrypt_support_email: ""
      tls_cert_path: ""
      tls_key_path: ""

      log:
        level: info
        format: text

      policy:
        mode: file
        path: ""
    '';
in {
  options.modules.nix.containers.headscale.enable = lib.mkEnableOption "Enable Headscale and Headplane Containers";

  config = lib.mkIf cfg.headscale.enable {
    networking.firewall = {
      allowedTCPPorts = [8080];
      allowedUDPPorts = [3478];
    };
    systemd.tmpfiles.rules = [
      "d ${headscalePath}/config 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      "d ${headscalePath}/lib 0755 ${cfg.mainUser} ${cfg.mainUser} -"
    ];
    virtualisation.oci-containers.containers = {
      headscale = {
        image = "headscale/headscale:0.26.0";
        autoStart = true;
        cmd = ["serve"];
        ports = [
          "8080:8080"
          "3478:3478/udp"
        ];
        volumes = [
          "${headscaleConfig}:/etc/headscale/config.yaml:ro"
          "${headscalePath}/lib:/var/lib/headscale"
        ];
        environment = {
          TZ = config.time.timeZone;
        };
        # labels = let
        #   name = "headscale";
        # in
        #   containerUtils.mkTraefikLabels {
        #     name = name;
        #     port = 8080;
        #   };
      };
    };
  };
}
