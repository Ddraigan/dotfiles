{...}: {
  homeManager.home-settings.leon-pc.leon = {
    inputs,
    config,
    pkgs,
    ...
  }: {
    modules = {
      desktop = {
        hypr = {
          hyprland.mod = "SUPER";
          hyprlock.mainMonitor = "DP-1";
        };
        nemo.extensions = [
          pkgs.nemo-preview
        ];
      };
    };

    programs = {
      mpv = {
        enable = true;
      };
      element-desktop.enable = true;
      firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
    };

    wayland.windowManager.hyprland.settings = {
      config = {
        input = {
          kb_variant = "";
        };
      };
      monitor = [
        {
          _args = [
            {
              output = "DP-1";
              mode = "preferred";
              position = "0x0";
              scale = 1;
              bitdepth = 10;
              cm = "hdr";
              sdr_max_luminance = 250;
              sdr_min_luminance = 0.005;
              sdrbrightness = 1.0;
              sdrsaturation = 1.0;
            }
          ];
        }
        {
          _args = [
            {
              output = "DP-2";
              mode = "preferred";
              position = "auto-left";
              scale = "auto";
              bitdepth = 8;
            }
          ];
        }
      ];
    };

    home = {
      stateVersion = "24.05";
      packages = [
        pkgs.just
        inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.dgop

        # Image Stuff
        pkgs.gimp
        pkgs.loupe

        pkgs.unzip
        pkgs.zip
        pkgs.ripgrep
        pkgs.fzf
      ];
    };

    xdg.mimeApps.enable = true;
  };
}
