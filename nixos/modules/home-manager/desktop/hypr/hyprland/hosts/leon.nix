{
  lib,
  config,
  ...
}: {
  config = {
    wayland.windowManager.hyprland.settings = {
      config = {
        input = {
          kb_variant = "";
        };
      };
      # workspace_rule = [
      #   {
      #     workspace = "1";
      #     monitor = "monitor:DP-1";
      #     default = true;
      #   }
      #   {
      #     workspace = "2";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "3";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "4";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "5";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "6";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "7";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "8";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "9";
      #     monitor = "monitor:DP-1";
      #   }
      #   {
      #     workspace = "10";
      #     monitor = "monitor:DP-1";
      #   }
      #
      #   # Monitor 2 (DP-2) workspaces 11-20
      #   {
      #     workspace = "11";
      #     monitor = "monitor:DP-2";
      #     default = true;
      #   }
      #   {
      #     workspace = "12";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "13";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "14";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "15";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "16";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "17";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "18";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "19";
      #     monitor = "monitor:DP-2";
      #   }
      #   {
      #     workspace = "20";
      #     monitor = "monitor:DP-2";
      #   }
      # ];
      monitor = [
        {
          output = "DP-1";
          mode = "preferred";
          position = "0x0";
          scale = 1;
          bitdepth = 8;
        }
        {
          output = "DP-2";
          mode = "preferred";
          position = "auto-left";
          scale = "auto";
          bitdepth = 8;
        }
      ];
    };
  };
}
