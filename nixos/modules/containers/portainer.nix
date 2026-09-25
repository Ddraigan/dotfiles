{...}: {
  nixos.portainer = {
    lib,
    pkgs,
    config,
    containerUtils,
    ...
  }: let
    cfg = config.modules.nix.containers;
    portainerPath = "${cfg.dataPath}/portainer";
  in {
    config = {
      systemd.tmpfiles.rules = [
        "d ${portainerPath} 0755 ${cfg.mainUser} ${cfg.mainUser} -"
      ];

      virtualisation.oci-containers.containers.portainer = {
        image = "portainer/portainer-ce:2.39.6";
        autoStart = true;
        volumes = [
          "/var/run/docker.sock:/var/run/docker.sock"
          "${portainerPath}:/data"
        ];
        environment = {
          TZ = config.time.timeZone;
        };
        labels = containerUtils.mkTraefikLabelsWithAuth {
          name = "portainer";
          port = 9000;
        };
      };
    };
  };
}
