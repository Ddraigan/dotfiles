{ inputs, outputs, lib, config, pkgs, ... }:

{
  imports = with outputs.homeManagerModules; [
    hyprland
    tmux
    wezterm
    starship
    zsh
    waybar
    neovim
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];

    # Config for nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "leon";
    homeDirectory = "/home/leon";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs = {
    # wezterm = {
    #   enable = true;
    #   package = inputs.wezterm.packages.${pkgs.system}.default;
    # };
    home-manager.enable = true;
    git.enable = true;
    zsh.enable = true;
    #neovim.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.firefox
    pkgs.kitty
    pkgs.unzip
    pkgs.ripgrep
    pkgs.hyprshot

    # Wayland
    pkgs.grim
    pkgs.slurp
    pkgs.wl-clipboard
    pkgs.dunst
    pkgs.libnotify
    pkgs.rofi-wayland
    pkgs.networkmanagerapplet
    pkgs.pavucontrol

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override {
      fonts = [ "Hack" ];
    })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];



  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/leon/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = {
  # EDITOR = "emacs";
  # };



  # Apparantly this will fix mouse theme issues
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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
