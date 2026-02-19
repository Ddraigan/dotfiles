{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.nix.containers;
  cfddnsPath = "${cfg.dataPath}/cloudflare-ddns";
in {
  options.modules.nix.containers.cfddns.enable = lib.mkEnableOption "Enable cloudflare-ddns";
  config = lib.mkIf cfg.cfddns.enable {
    systemd.tmpfiles.rules = [
      "d ${cfddnsPath} 0755 ${cfg.mainUser} users -"
    ];

    virtualisation.oci-containers.containers.cloudflare-ddns = {
      image = "favonia/cloudflare-ddns:latest";
      autoStart = true;
      user = "1000:1000";
      extraOptions = [
        "--network=host"
        "--cap-drop=ALL"
        "--security-opt=no-new-privileges:true"
        "--read-only"
      ];
      environmentFiles = [
        "/home/leon/secrets/cloudflare-ddns.env"
      ];
      volumes = [
        "${cfddnsPath}:/data"
      ];
    };
  };
}
