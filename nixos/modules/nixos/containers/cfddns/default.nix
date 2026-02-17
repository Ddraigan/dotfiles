{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.modules.nix.containers.cfddns;
  mainUser = "leon";
  dataPath = "${config.users.users.${mainUser}.home}/appdata";
  cfddnsPath = "${dataPath}/cloudflare-ddns";
in {
  options.modules.nix.containers.cfddns.enable = lib.mkEnableOption "Enable cloudflare-ddns";
  config = lib.mkIf cfg.enable {
    systemd.tmpfiles.rules = [
      "d ${cfddnsPath} 0755 ${mainUser} users -"
    ];

    virtualisation.oci-containers.containers.cloudflare-ddns = {
      image = "favonia/cloudflare-ddns:latest";
      autoStart = true;
      user = "1000:1000";
      cmd = [
        "--network-mode=host"
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
