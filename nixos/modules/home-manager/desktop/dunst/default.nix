{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.dunst.enable = lib.mkEnableOption "Enable Dunst";

  config = lib.mkIf config.modules.desktop.dunst.enable {
    home.packages = [
      pkgs.libnotify
    ];
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "mauve";
        };
        size = "32x32";
      };
      settings = {
        global = {
          # Display
          follow = "mouse";
          # Notification Window (Not each single notification)
          width = "(0, 350)";
          height = "(0, 300)";
          offset = "(20, 30)";
          origin = "top-right";
          notification_limit = 10;

          indicate_hidden = true;
          enable_posix_regex = true;
          gap_size = 8;
          padding = 8;
          horizontal_padding = 16;
          frame_width = 1;
          sort = "no";

          # Progress bar
          progress_bar_frame_width = 0;
          progress_bar_corner_radius = 3;

          # Colors
          foreground = "#cdd6f4";
          frame_color = "#b4befe";
          background = "#1e1e2e";
          highlight = "#74c7ec";
          separator_color = "frame";

          # Text
          font = "DejaVu Sans 10";
          markup = "full";
          format = "<b>󰁕 %a</b>\n%s\n<i>%b</i>";
          # format = "<small>%a</small>\n<big><b>%s</b></big>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = -1;
          hide_duplicate_count = false;

          # Icon
          icon_position = "left";
          min_icon_size = 54;
          max_icon_size = 80;
          # icon_path = "#TODO";
          icon_corner_radius = 4;

          # Misc/Advanced
          dmenu = "rofi -show drun --prompt 'Open with'";
          corner_radius = 10;

          # Mouse
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };
        urgency_low = {
          default_icon = "./icons/bell-badge-low.svg";
          foreground = "#a6e3a1";
          frame_color = "#a6e3a1";
          timeout = 4;
        };
        urgency_normal = {
          default_icon = "./icons/bell-badge.svg";
          foreground = "#74c7ec";
          frame_color = "#74c7ec";
          timeout = 8;
        };
        urgency_critical = {
          default_icon = "./icons/alert-decagram.svg";
          foreground = "#f38ba8";
          frame_color = "#f38ba8";
          highlight = "#f5c2e7, #eba0ac";
          timeout = 0;
        };
        fullscreen_delay_everything = {
          fullscreen = "delay";
        };
      };
    };
  };
}
