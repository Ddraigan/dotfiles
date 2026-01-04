{
  pkgs,
  lib,
  config,
  nixosConfig,
  ...
}: {
  options.modules.desktop.lutris.enable = lib.mkEnableOption "Enable Lutris Game Launcher";

  config = lib.mkIf config.modules.desktop.lutris.enable {
    programs.lutris = {
      enable = true;
      # steamPackage = nixosConfig.programs.steam.package;
      extraPackages = with pkgs; [
        mangohud
        winetricks
        gamescope
        gamemode
        umu-launcher
      ];
      protonPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
