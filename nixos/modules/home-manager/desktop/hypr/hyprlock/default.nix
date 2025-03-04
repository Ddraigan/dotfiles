{ pkgs, lib, config, inputs, namespace, system, ... }:

let
  hyprlock-package = inputs.hyprlock.packages.${system}.hyprlock;
  username = config.${namespace}.user.name;
  main-monitor = "";
in
{
  options.modules.desktop.hypr.hyprlock = {
    enable = lib.mkEnableOption "Enable Hyprlock";
  };
  config = lib.mkIf config.modules.desktop.hypr.hyprlock.enable {
    modules.desktop.hypr.hyprland.settings = {
      bind = [
        "$mod CTRL, ESC, exec, hyprlock-blur"
      ];
    };
    programs.hyprlock = {
      enable = true;
      package = hyprlock-package;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 100;
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
        # image = {
        #   monitor = "${main-monitor}";
        #   path = "/home/${username}/Pictures/<image here>";
        #
        #   rounding = "-1"; #Negative makes a circle
        #   position = "0, 50";
        #   halign = "center";
        #   valign = "center";
        # };
        label = [
          {
            monitor = "${main-monitor}";
            text = "$TIME";
            # color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            # font_family = "JetBrains Mono";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "${main-monitor}";
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
          monitor = "${main-monitor}";
          size = "200,50";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          # outer_color = "rgba(0, 0, 0, 0)";
          # inner_color = "rgba(0, 0, 0, 0.2)";
          # font_color = "rgb(111, 45, 104)";
          fade_on_empty = false;
          rounding = -1;
          # check_color = "rgb(30, 107, 204)";
          placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          hide_input = false;
          position = "0, -100";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
