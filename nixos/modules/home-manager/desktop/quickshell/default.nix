{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  options.modules.desktop.quickshell.enable = lib.mkEnableOption "Enable Quickshell";
  config = lib.mkIf config.modules.desktop.quickshell.enable {
    home = {
      packages = [
        inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      file = {
        ".config/quickshell" = {
          source = ./config;
        };
      };
    };
  };
}
