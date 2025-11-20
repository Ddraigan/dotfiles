{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  modules = {
    theme.stylix.enable = true;
    desktop = {
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

  fonts.fontconfig.enable = true;

  home = {
    username = "leon";
    homeDirectory = "/home/leon";
    stateVersion = "24.05";
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
      pkgs.nerd-fonts.hack
    ];
  };

  xdg = {
    configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
}
