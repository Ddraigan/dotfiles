{ inputs, outputs, lib, config, pkgs, ... }:

{
  # These imports activate the module
  imports = with outputs.homeManagerModules; [
    hyprland
    rofi
    catppuccin
    hyprpaper
    tmux
    wezterm
    starship
    zsh
    waybar
    neovim
    zoxide
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];
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
