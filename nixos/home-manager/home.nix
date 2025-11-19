{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
      nemo = {
        enable = true;
        openInTerminal = {
          exec = config.global.primaryTerminalCommand;
          exec-arg = "--cwd=%d";
        };
        extensions = [];
      };
      waybar.enable = true;
      dunst.enable = true;
      spicetify.enable = true;
    };
    terminal = {
      nvim.enable = true;
      starship.enable = true;
      tmux.enable = true;
      wezterm = {
        enable = true;
        primary-terminal = true;
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

  services.easyeffects.enable = false;

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
    packages = [
      pkgs.gimp
      pkgs.loupe
      pkgs.firefox
      pkgs.lua-language-server
      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
      pkgs.nerd-fonts.hack
      pkgs.stylua
    ];
  };

  xdg = {
    configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  };
}
