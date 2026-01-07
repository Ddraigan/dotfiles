{
  lib,
  config,
  ...
}: {
  config = {
    # monitor = [
    #   "DP-1, preferred, 0x0, 1, bitdepth, 8"
    #   "DP-2, preferred, auto-left, auto, bitdepth, 8"
    # ];

    wayland.windowManager.hyprland.settings = {
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
        kb_variant = "qwerty";
      };
    };
  };
}
