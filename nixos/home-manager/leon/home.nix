{
  inputs,
  config,
  pkgs,
  ...
}: {
  global.home.fonts = {
    enable = true;
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
    lib.uwsm.enable = true;
    theme.stylix.enable = true;
    desktop = {
      ashell.enable = false;
      dunst.enable = false;
      dms.enable = false;
      noctalia.enable = true;
      lutris.enable = true;
      obs.enable = true;
      hypr = {
        hyprland = {
          enable = true;
          mod = "SUPER";
        };
        hyprpaper.enable = false;
        hyprlock = {
          enable = true;
          mainMonitor = "DP-1";
        };
        hypridle.enable = true;
      };
      mpv.enable = true;
      nemo = {
        enable = true;
        extensions = [
          pkgs.nemo-preview
        ];
      };
      rofi.enable = true;
      spicetify.enable = true;
      waybar.enable = false;
      wlogout.enable = true;
      zen.enable = true;
    };
    terminal = {
      nvim.enable = true;
      fastfetch.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm = {
        enable = true;
        primaryTerminal = true;
      };
      zoxide.enable = true;
      eza.enable = true;
      zsh.enable = true;
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
    home-manager.enable = true;
    element-desktop.enable = true;
    firefox.enable = true;
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
    configFile = {
      "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
    };
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
