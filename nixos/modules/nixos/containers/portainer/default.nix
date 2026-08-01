{
  config,
  lib,
  pkgs,
  containerUtils,
  ...
}: let
  cfg = config.modules.nix.containers;
  portainerPath = "${cfg.dataPath}/portainer";
in {
  options.modules.nix.containers.portainer.enable = lib.mkEnableOption "Enable Portainer Container";
  
  config = lib.mkIf cfg.portainer.enable {
    systemd.tmpfiles.rules = [
      "d ${portainerPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
    ];

    virtualisation.oci-containers.containers.portainer = {
      image = "portainer/portainer-ce:latest";
      autoStart = true;
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "${portainerPath}:/data"
      ];
      environment = {
        TZ = config.time.timeZone;
      };
      labels = containerUtils.mkTraefikLabels {
        name = "portainer";
        port = 9000;
      };
    };
  };
}
