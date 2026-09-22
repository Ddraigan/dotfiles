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
  };

  modules = {
    desktop = {
      hypr = {
        hyprland.mod = "SUPER";
        hyprlock.mainMonitor = "eDP-1";
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
    enable = true;
    package = pkgs.unstable.easyeffects;
  };

  programs = {
    home-manager.enable = true;
    element-desktop.enable = true;
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
        kb_layout = "us";
        kb_variant = "dvorak";

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace = true;
      };
    };
    monitor = [
      {
        output = "eDP-1";
        mode = "preferred";
        position = "0x0";
        scale = 1;
        bitdepth = 8;
      }
    ];
  };

  home = {
    username = "leon";
    homeDirectory = "/home/leon";
    stateVersion = "24.05";
    packages = [
      pkgs.just
      inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default

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
    configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
}
