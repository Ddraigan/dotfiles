{
  lib,
  config,
  ...
}: {
  config = {
    wayland.windowManager.hyprland.settings = {
      monitorv2 = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "0x0";
          scale = 1;
          bitdepth = 8;
        }
      ];

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
  };
}
