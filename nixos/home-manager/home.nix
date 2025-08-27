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

  stylix = {
    enable = true;
    autoEnable = true;
    homeManagerIntegration.autoImport = false;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
    opacity = {
      applications = 0.5;
    };
    iconTheme = {
      enable = true;
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
    base16Scheme = {
      base00 = "1e1e2e"; # base
      base01 = "181825"; # mantle
      base02 = "313244"; # surface0
      base03 = "45475a"; # surface1
      base04 = "585b70"; # surface2
      base05 = "cdd6f4"; # text
      base06 = "f5e0dc"; # rosewater
      base07 = "b4befe"; # lavender
      base08 = "f38ba8"; # red
      base09 = "fab387"; # peach
      base0A = "f9e2af"; # yellow
      base0B = "a6e3a1"; # green
      base0C = "94e2d5"; # teal
      base0D = "89b4fa"; # blue
      base0E = "cba6f7"; # mauve
      base0F = "f2cdcd"; # flamingo
    };
    targets = {
      hyprland = {
        enable = false;
      };
      waybar.enable = false;
      tmux.enable = false;
      zen-browser = {
        enable = true;
        profileNames = ["default"];
      };
      wezterm.enable = false;
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
