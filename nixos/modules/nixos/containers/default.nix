{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./traefik
    ./homeass
    ./cfddns
  ];
  options.modules.nix.containers = with lib; {
    domain = mkOption {
      type = types.str;
      description = "Base domain used for Traefik-routed services.";
    };

    mainUser = mkOption {
      type = types.str;
      description = "Primary user that owns container data directories.";
    };

    dataPath = mkOption {
      type = types.path;
      default = "/home/${config.modules.nix.containers.mainUser}/appdata";
      description = "Base path for container persistent data.";
    };
  };
  config = {
    modules.nix.containers.mkPath =
      name: "${config.modules.nix.containers.dataPath}/${name}";
  };
}
