{...}: {
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

  nixos.gaming = {
    lib,
    pkgs,
    config,
    inputs,
    ...
  }: {
    config = {
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
          # package = pkgs.millennium-steam;
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
          capSysNice = false;
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
  };

  homeManager.gaming = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = {
      home.shellAliases = {
        steamos = "uwsm app -- gamescope -W 2560 -H 1440 -- steam -steamos3 -gamepadui -steamdeck -steampal";
      };
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
  };
}
