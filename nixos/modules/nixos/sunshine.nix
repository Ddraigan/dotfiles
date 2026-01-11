{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.modules.nix.sunshine;
in {
  options = {modules.nix.sunshine.enable = lib.mkEnableOption "Enable Sunshine";};
  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
    };
    networking.firewall = {
      allowedTCPPorts = [47984 47989 47990 48010];
      allowedUDPPortRanges = [
        {
          from = 47998;
          to = 48000;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };
  };
}
