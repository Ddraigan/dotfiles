{
  inputs,
  pkgs,
  lib,
  config,
  colours,
  ...
}: let
  cfg = config.modules.desktop.noctalia;
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.modules.desktop.noctalia = {
    enable = lib.mkEnableOption "Enable Noctalia Shell";
  };
  config = lib.mkIf cfg.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings = builtins.fromJSON (builtins.readFile ./settings.json);
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
        };
        version = 1;
      };
      colors = with colours.hex; {
        mError = red;
        mOnError = text;
        mOnPrimary = crust;
        mOnSecondary = crust;
        mOnSurface = text;
        mOnSurfaceVariant = text;
        mOnTertiary = text;
        mOnHover = text;
        mOutline = crust;
        mPrimary = mauve;
        mSecondary = maroon;
        mShadow = crust;
        mSurface = mantle;
        mHover = base;
        mSurfaceVariant = base;
        mTertiary = pink;
      };
    };
    wayland.windowManager.hyprland.settings = {
      "$noctipc" = "noctalia-shell ipc call";

      bind = [
        "SUPER, SPACE, exec, $noctipc launcher toggle"
        "SUPER, S, exec, $noctipc controlCenter toggle"
        "SUPER, comma, exec, $noctipc settings toggle"
      ];

      bindel = [
        # Media
        ", XF86AudioRaiseVolume, exec, $noctipc volume increase"
        ", XF86AudioLowerVolume, exec, $noctipc volume decrease"
        ", XF86AudioVolumeUp, exec, $noctipc volume increase"
        ", XF86AudioVolumeDown, exec, $noctipc volume decrease"

        # Brightness
        ", XF86MonBrightnessUp, exec, $noctipc brightness increase"
        ", XF86MonBrightnessDown, exec, $noctipc brightness decrease"
        ", XF86BrightnessUp, exec, $noctipc brightness increase"
        ", XF86BrightnessDown, exec, $noctipc brightness decrease"
      ];

      bindl = [
        # Media
        ", XF86AudioPlay, exec, $noctipc media playPause"
        ", XF86AudioPause, exec, $noctipc media pause"
        ", XF86AudioPrev, exec, $noctipc media previous"
        ", XF86AudioNext, exec, $noctipc media next"
        ", XF86AudioStop, exec, $noctipc media stop"

        # Audio
        ", XF86AudioMute, exec, $noctipc volume muteOutput"
        ", XF86AudioMicMute, exec, $noctipc volume muteInput"
      ];
    };
  };
}
