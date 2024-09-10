{ inputs, outputs, lib, config, pkgs, ... }:

{
  # These imports activate the module
  imports = with outputs.homeManagerModules; [
    hyprland
    tmux
    wezterm
    starship
    zsh
    waybar
    neovim
    rofi-wayland
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
    packages = [
      pkgs.firefox
      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
      pkgs.zoxide

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
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    # home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # };
    # This fixes mouse theme issues in hyprland
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
