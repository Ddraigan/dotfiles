{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    environment.systemPackages = with pkgs;
      [
        mangohud
        protonplus
        pkgsi686Linux.freetype
        pkgsi686Linux.fontconfig
        pkgsi686Linux.zlib
      ];

    hardware = {
      graphics = {
        enable = true; # Enable OpenGL
        enable32Bit = true;
        extraPackages = with pkgs; [
          vulkan-validation-layers
        ];
      };
    };

    programs = {
      steam = {
        enable = true;
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
            start = "${pkgs.libnotify}/bin/notify-send -a 'Gamemode' 'Optimizations activated'";
            end = "${pkgs.libnotify}/bin/notify-send -a 'Gamemode' 'Optimizations deactivated'";
          };
        };
      };
    };
  };

  flake.modules.homeManager.gaming = {pkgs, ...}: {
    programs.lutris = {
      enable = true;
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
