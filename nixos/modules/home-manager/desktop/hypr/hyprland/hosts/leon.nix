{
  lib,
  config,
  ...
}: {
  config = {
    wayland.windowManager.hyprland.settings = {
      workspace = [
        # Monitor 1 (DP-1) workspaces 1-10
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"
        "10, monitor:DP-1"
        "99, monitor:DP-1"

        # Monitor 2 (DP-2) workspaces 11-20
        "11, monitor:DP-2, default:true"
        "12, monitor:DP-2"
        "13, monitor:DP-2"
        "14, monitor:DP-2"
        "15, monitor:DP-2"
        "16, monitor:DP-2"
        "17, monitor:DP-2"
        "18, monitor:DP-2"
        "19, monitor:DP-2"
        "20, monitor:DP-2"
      ];
      monitorv2 = [
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

      input = {
        kb_variant = "";
      };
    };
  };
}
