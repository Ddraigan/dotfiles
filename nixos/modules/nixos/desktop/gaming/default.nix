{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.nix.desktop.gaming.enable = lib.mkEnableOption "Enable Gaming Config";
  config = lib.mkIf config.modules.nix.desktop.gaming.enable {
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-ng
      protonup-qt
      # steamtinkerlaunch

      pkgsi686Linux.freetype
      pkgsi686Linux.fontconfig
      pkgsi686Linux.zlib
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.steamtinkerlaunch
        ];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode.enable = true;
    };
  };
}
