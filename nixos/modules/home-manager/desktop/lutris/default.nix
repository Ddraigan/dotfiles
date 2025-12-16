{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.lutris.enable = lib.mkEnableOption "Enable Lutris Game Launcher";

  config =
    lib.mkIf config.modules.desktop.lutris.enable {
      programs.lutris = {
        enable = true;
        steamPackage = osConfig.programs.steam.package;
        protonPackages = [
          pkgs.proton-ge-bin
        ];
      };
    };
}
