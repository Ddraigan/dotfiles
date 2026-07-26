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
      monitor = [
        {
          _args = [
            {
              output = "DP-1";
              mode = "preferred";
              position = "0x0";
              scale = 1;
              bitdepth = 10;
              cm = "hdr";
              sdr_max_luminance = 250;
              sdr_min_luminance = 0.005;
              sdrbrightness = 1.0;
              sdrsaturation = 1.0;
            }
          ];
        }
        {
          _args = [
            {
              output = "DP-2";
              mode = "preferred";
              position = "auto-left";
              scale = "auto";
              bitdepth = 8;
            }
          ];
        }
      ];
    };
  };
}
