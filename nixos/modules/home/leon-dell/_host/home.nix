{
  inputs,
  config,
  pkgs,
  ...
}: {
  modules = {
    desktop = {
      hypr = {
        hyprland.mod = "SUPER";
        hyprlock.mainMonitor = "eDP-1";
      };
      nemo.extensions = [
        pkgs.nemo-preview
      ];
    };
  };

  services.easyeffects = {
    enable = true;
    package = pkgs.unstable.easyeffects;
  };

  programs = {
    mpv = {
      enable = true;
    };
    element-desktop.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    config = {
      input = {
        kb_layout = "us";
        kb_variant = "dvorak";

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace = true;
      };
    };
    monitor = [
      {
        output = "eDP-1";
        mode = "preferred";
        position = "0x0";
        scale = 1;
        bitdepth = 8;
      }
    ];
  };

  home = {
    stateVersion = "24.05";
    packages = [
      pkgs.just
      inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default

      # Image Stuff
      pkgs.gimp
      pkgs.loupe

      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
    ];
  };
}
