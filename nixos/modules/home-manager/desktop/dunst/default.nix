{ pkgs
, inputs
, lib
, config
, ...
}: {
  options.modules.desktop.dunst.enable = lib.mkEnableOption "Enable Dunst";

  config = lib.mkIf config.modules.desktop.dunst.enable {
    home.packages = [
      pkgs.libnotify
    ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          # Display
          follow = "mouse";
          width = 350;
          height = "(0, 300)";
          origin = "top-right";
          offset = "(35, 35)";
          indicate_hidden = "yes";
          notification_limit = 10;
          gap_size = 12;
          padding = 12;
          horizontal_padding = 20;
          frame_width = 1;
          sort = "no";

          # Progress bar
          progress_bar_frame_width = 0;
          progress_bar_corner_radius = 3;

          # Colors
          foreground = "#cdd6f4";
          frame_color = "#181825";
          highlight = "#a6e3a1, #94e2d5";

          # Text
          font = "Noto Sans CJK JP 10";
          markup = "full";
          format = "<small>%a</small>\n<big><b>%s</b></big>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = -1;
          hide_duplicate_count = false;

          # Icon
          icon_position = "left";
          min_icon_size = 54;
          max_icon_size = 80;
          icon_path = "#TODO";
          icon_corner_radius = 4;

          # Misc/Advanced
          dmenu = "rofi -show drun --prompt 'Open with'";
          corner_radius = 10;

          # Mouse
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";

          urgency_low = {
            background = "#313244";
            timeout = 3;
          };

          urgency_normal = {
            background = "#313244";
            timeout = 8;
          };

          urgency_critical = {
            background = "#f38ba8";
            frame_color = "#cba6f7";
            highlight = "#f5c2e7, #eba0ac";
            timeout = 0;
          };

          # Rules
          fullscreen_delay_everything = {
            fullscreen = delay;
          };
        };
      };
    };
  };
}
