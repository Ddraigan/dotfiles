{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  options.modules.nix.desktop.gaming.enable = lib.mkEnableOption "Enable Gaming Config";
  config = lib.mkIf config.modules.nix.desktop.gaming.enable {
    nixpkgs = {
      overlays = [inputs.millennium.overlays.default];
    };
    environment.systemPackages = with pkgs; [
      mangohud
      protonplus
      # protonup-qt
      # protonup-rs # Rust CLI installer
      # steamtinkerlaunch

      pkgsi686Linux.freetype
      pkgsi686Linux.fontconfig
      pkgsi686Linux.zlib
    ];

    programs = {
      steam = {
        enable = true;
        package = pkgs.millennium-steam;
        gamescopeSession.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraPackages = with pkgs; [
          gamemode
        ];
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          steamtinkerlaunch
        ];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          custom = {
            start = "notify-send -a 'Gamemode' 'Optimizations activated'";
            end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
          };
        };
      };
    };
  };
}
