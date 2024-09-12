{ inputs, outputs, lib, config, pkgs, ... }:

{
  # These imports activate the module
  imports = with outputs.homeManagerModules; [
    hyprland
    ags
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
    zsh.enable = true;
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
      pkgs.gnome.nautilus

      # Wayland
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
      pkgs.dunst
      pkgs.libnotify
      pkgs.networkmanagerapplet
      pkgs.pavucontrol
      pkgs.hyprshot

      (pkgs.nerdfonts.override {
        fonts = [ "Hack" ];
      })
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.catppuccin-cursors.mochaLavender;
      size = 16;
      name = "mochaLavender";
      # package = pkgs.bibata-cursors;
      # name = "Bibata-Modern-Classic";
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
    # cursorTheme.package = pkgs.catppuccin-cursors.mochaLavender;
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita"; # ????
      # package = pkgs.gnome.adwaita-icon-theme;
      # name = "Adwaita";
    };
  };
}
