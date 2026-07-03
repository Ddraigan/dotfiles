{
  lib,
  config,
  ...
}: {
  config = {
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
  };
}
