{
  config,
  pkgs,
  lib,
  ...
}: let
  mainUser = "leon";
  dataPath = "${config.users.users.${mainUser}.home}/appdata";
  cfddnsPath = "${dataPath}/cloudflare-ddns";
in {
  config = {
    systemd.tmpfiles.rules = [
      "d ${cfddnsPath} 0755 ${mainUser} users -"
    ];

    virtualisation.oci-containers.containers.cloudflare-ddns = {
      image = "favonia/cloudflare-ddns:latest";
      # Use host networking to make IPv6 easier
      networkMode = "host";
      restartPolicy = "always";
      user = "1000:1000";
      readOnly = true;
      securityOpt = ["no-new-privileges:true"];
      environmentFiles = [
        "/home/leon/secrets/cloudflare-ddns.env"
      ];
      volumes = [
        "${cfddnsPath}:/data"
      ];
    };
  };
}
