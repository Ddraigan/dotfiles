{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  catppuccin = {
    enable = false;
    flavor = "mocha";
    accent = "pink";
    cursors = {
      enable = true;
      flavor = "mocha";
      accent = "sapphire";
    };
    gtk = {
      enable = false;
      flavor = "mocha";
      accent = "pink";
      size = "standard";
      tweaks = ["normal"];
    };
  };

  dconf = {
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "/run/current-system/sw/bin/wezterm-cwd";
        # exec-arg = ""; # argument
      };
    };
  };

  modules = {
    desktop = {
      hypr = {
        hyprland.enable = true;
        hyprpaper.enable = true;
        hyprlock.enable = true;
      };
      rofi.enable = false;
      walker.enable = true;
      waybar.enable = true;
      dunst.enable = true;
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
    overlays = [inputs.self.overlays.unstable-packages];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  services.easyeffects.enable = true;

  programs = {
    home-manager.enable = true;
    element-desktop.enable = true;
    spotify-player.enable = true;
    git = {
      enable = true;
      userName = "Ddraigan";
      userEmail = "lkjjones1999@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  fonts = {
    fontconfig.enable = true;
  };

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
    file = {
      ".gnome2/accels/nemo".text = ''
        (gtk_accel_path "<Actions>/DirViewActions/OpenInTerminal" "F4")
      '';
    };
    packages = [
      pkgs.firefox
      pkgs.lua-language-server
      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
      inputs.zen-browser.packages."${pkgs.system}".default
      pkgs.nerd-fonts.hack
      pkgs.stylua

      # (pkgs.nerdfonts.override {
      #   fonts = ["Hack"];
      # })
    ];
    pointerCursor = {
      gtk.enable = true;
      size = 16;
    };
  };

  gtk = {
    enable = true;
    # iconTheme = {
    #   package = pkgs.morewaita-icon-theme;
    #   name = "MoreWaita";
    # };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
  };
}
