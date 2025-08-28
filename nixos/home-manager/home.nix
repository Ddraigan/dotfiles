{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # catppuccin = {
  #   enable = false;
  #   flavor = "mocha";
  #   accent = "pink";
  #   # cursors = {
  #   #   enable = true;
  #   #   flavor = "mocha";
  #   #   accent = "sapphire";
  #   # };
  #   gtk = {
  #     enable = false;
  #     flavor = "mocha";
  #     accent = "pink";
  #     size = "standard";
  #     tweaks = ["normal"];
  #   };
  # };

  dconf = {
    # settings = {
    #   "org/cinnamon/desktop/applications/terminal" = {
    #     exec = "/run/current-system/sw/bin/wezterm-cwd";
    #     # exec-arg = ""; # argument
    #   };
    # };
    settings = {
      "org/cinnamon/desktop/interface" = {
        can-change-accels = true;
      };
    };
  };

  modules = {
    theme = {
      stylix.enable = true;
    };
    desktop = {
      hypr = {
        hyprland.enable = true;
        hyprpaper.enable = true;
        hyprlock.enable = true;
      };
      rofi.enable = true;
      walker.enable = false;
      waybar.enable = true;
      dunst.enable = true;
      spicetify.enable = true;
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
    zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      profiles."default" = {
        userChrome = '''';
        spaces = {
          "First" = {
            id = "bf0810f0-8216-458e-946b-d8e401616107";
            theme.opacity = 0.0;
            position = 1000;
          };
          "Second" = {
            id = "c0b6972d-e68f-4fd8-a60f-f3c0df9e4ca8";
            theme.opacity = 0.0;
            position = 2000;
          };
        };
      };
    };
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
      pkgs.nemo-with-extensions
      pkgs.ripgrep
      pkgs.fzf
      pkgs.nerd-fonts.hack
      pkgs.stylua
    ];
    # pointerCursor = {
    #   gtk.enable = true;
    #   size = 16;
    # };
  };

  xdg = {
    desktopEntries.nemo = {
      name = "Nemo";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = ["nemo.desktop"];
        "application/x-gnome-saved-search" = ["nemo.desktop"];
      };
    };
  };

  # gtk = {
  # enable = true;
  # iconTheme = {
  #   package = pkgs.morewaita-icon-theme;
  #   name = "MoreWaita";
  # };
  # iconTheme = {
  #   package = pkgs.candy-icons;
  #   name = "candy-icons";
  # };
  # };
}
