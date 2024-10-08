{ inputs, lib, config, pkgs, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "pink";
    pointerCursor = {
      enable = true;
      flavor = "mocha";
      accent = "sapphire";
    };
  };

  modules = {
    desktop = {
      hypr = {
        hyprland.enable = true;
        hyprpaper.enable = true;
      };
      rofi.enable = true;
      waybar.enable = true;
    };
    terminal = {
      nvim.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
    };
  };

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable-packages ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Ddraigan";
      userEmail = "lkjjones1999@gmail.com";
    };
  };

  fonts.fontconfig.enable = true;

  home = {
    username = "leon";
    homeDirectory = "/home/leon";
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      cd = "z";
    };
    packages = [
      pkgs.firefox
      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf

      (pkgs.nerdfonts.override {
        fonts = [ "Hack" ];
      })
    ];
    pointerCursor = {
      gtk.enable = true;
      size = 16;
    };
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "pink";
      size = "standard";
      tweaks = [ "normal" ];
    };
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita"; # ????
    };
  };
}
