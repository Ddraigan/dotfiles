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
      protonplus
      protonup-qt
      # protonup-rs # Rust CLI installer
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
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          steamtinkerlaunch
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
