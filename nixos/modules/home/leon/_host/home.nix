{
  inputs,
  config,
  pkgs,
  ...
}: {
  global.home.fonts = {
    mono = {
      name = "Hack Nerd Font, Hack NF";
      package = pkgs.nerd-fonts.hack;
    };
    sans = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
    serif = {
      name = "DejaVu Serif";
      package = pkgs.dejavu_fonts;
    };
    icons = {
      enable = true;
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
      size = "32x32";
    };
  };

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

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  services.easyeffects = {
    enable = false;
    package = pkgs.unstable.easyeffects;
  };

  programs = {
    mpv = {
      enable = true;
    };
    home-manager.enable = true;
    element-desktop.enable = true;
    firefox = {
      enable = true;
      configPath = "${config.xdg.configHome}/mozilla/firefox";
    };
    git = {
      enable = true;
      settings = {
        user = {
          email = "lkjjones1999@gmail.com";
          name = "Ddraigan";
        };
        init.defaultBranch = "main";
      };
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
    username = "leon";
    homeDirectory = "/home/leon";
    stateVersion = "24.05"; # Don't change this I'm pretty sure
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

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["zen-beta.desktop"];
        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
      };
    };
  };
}
