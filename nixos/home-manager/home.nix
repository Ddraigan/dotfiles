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
  };
  modules = {
    theme.stylix.enable = true;
    desktop = {
      ashell.enable = true;
      hypr = {
        hyprland = {
          enable = true;
          uwsm = true;
        };
        hyprpaper.enable = true;
        hyprlock.enable = true;
      };
      rofi.enable = true;
      walker.enable = false;
      zen.enable = true;
      nemo = {
        enable = true;
        extensions = [
          pkgs.nemo-preview
        ];
      };
      waybar.enable = true;
      dunst.enable = true;
      spicetify.enable = true;
      wlogout.enable = true;
    };
    terminal = {
      nvim.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm = {
        enable = true;
        primaryTerminal = true;
      };
      zoxide.enable = true;
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
    enable = true;
    package = pkgs.unstable.easyeffects;
  };

  programs = {
    home-manager.enable = true;
    element-desktop.enable = true;
    git = {
      enable = true;
      userName = "Ddraigan";
      userEmail = "lkjjones1999@gmail.com";
      extraConfig = {
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

      # Image Stuff
      pkgs.gimp
      pkgs.loupe

      pkgs.firefox
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
