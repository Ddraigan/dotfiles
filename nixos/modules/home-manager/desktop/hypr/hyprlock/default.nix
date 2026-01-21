{
  pkgs,
  lib,
  config,
  inputs,
  uwsmUtils,
  colours,
  ...
}: let
  cfg = config.modules.desktop.hypr.hyprlock;
  hyprlock-package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.hyprlock;
  hyprland-config = config.modules.desktop.hypr.hyprland;
in
  with lib; {
    options.modules.desktop.hypr.hyprlock = {
      enable = mkEnableOption "Enable Hyprlock";
      mainMonitor = mkOption {
        type = types.str;
        example = "DP-1 (usually eDP-1 for laptop)";
        description = ''
          Name of the primary monitor output (e.g. "DP-1", "HDMI-A-1", "eDP-1").
        '';
      };
    };
    config = lib.mkIf cfg.enable {
      wayland.windowManager.hyprland.settings.bind = lib.mkIf hyprland-config.enable [
        "${hyprland-config.mod}, TAB, exec, ${uwsmUtils.wrap "hyprlock"}"
      ];
      programs.hyprlock = {
        enable = true;
        package = hyprlock-package;
        settings = {
          general = {
            disable_loading_bar = true;
            grace = 5;
            hide_cursor = true;
            no_fade_in = false;
          };
          background = [
            {
              monitor = "";
              path = "screenshot";
              blur_passes = 2; # 0 disables blurring
              blur_size = 3;
              brightness = 0.3;
            }
          ];
          label = [
            {
              monitor = "${cfg.mainMonitor}";
              text = "$TIME";
              # color = "rgba(242, 243, 244, 0.75)";
              font_size = 95;
              # font_family = "JetBrains Mono";
              position = "0, 300";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "${cfg.mainMonitor}";
              text = ''cmd[update:1000] echo $(date +"%A, %B %d")'';
              # color = "rgba(242, 243, 244, 0.75)";
              font_size = 22;
              # font_family = "JetBrains Mono";
              position = "0, 200";
              halign = "center";
              valign = "center";
            }
          ];
          input-field = {
            monitor = "${cfg.mainMonitor}";
            size = "200,50";
            outline_thickness = 2;
            dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            # outer_color = "rgba(0, 0, 0, 0)";
            outer_color = colours.rgba colours.rgb.crust 0.0;
            inner_color = colours.rgba colours.rgb.crust 0.2;
            font_color = colours.rgb.mauve;
            fade_on_empty = false;
            rounding = -1;
            check_color = colours.rgb.blue;
            placeholder_text = ''<i><span foreground="#${colours.hex.subtext1}">Input Password...</span></i>'';
            hide_input = false;
            position = "0, -100";
            halign = "center";
            valign = "center";
          };
        };
      };
    };
  }
