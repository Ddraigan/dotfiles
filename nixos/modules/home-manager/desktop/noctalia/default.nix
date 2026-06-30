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
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
      # plugins = {
      #   sources = [
      #     {
      #       enabled = true;
      #       name = "Official Noctalia Plugins";
      #       url = "https://github.com/noctalia-dev/noctalia-plugins";
      #     }
      #   ];
      #   states = {
      #   };
      #   version = 1;
      # };
      # colors = with colours.hex; {
      #   mError = red;
      #   mOnError = text;
      #   mOnPrimary = crust;
      #   mOnSecondary = crust;
      #   mOnSurface = text;
      #   mOnSurfaceVariant = text;
      #   mOnTertiary = text;
      #   mOnHover = text;
      #   mOutline = crust;
      #   mPrimary = mauve;
      #   mSecondary = maroon;
      #   mShadow = crust;
      #   mSurface = mantle;
      #   mHover = base;
      #   mSurfaceVariant = base;
      #   mTertiary = pink;
      # };
    };
    wayland.windowManager.hyprland.settings = {
      "$noctipc" = "noctalia msg";

      bind = [
        "SUPER, D, exec, $noctipc panel-toggle launcher"
        "SUPER, S, exec, $noctipc panel-toggle control-center"
        "SUPER, comma, exec, $noctipc settings-toggle"
      ];

      bindel = [
        # Audio
        ", XF86AudioRaiseVolume, exec, $noctipc volume-up"
        ", XF86AudioLowerVolume, exec, $noctipc volume-down"
        ", XF86AudioVolumeUp, exec, $noctipc volume-up"
        ", XF86AudioVolumeDown, exec, $noctipc volume-down"

        # Brightness
        ", XF86MonBrightnessUp, exec, $noctipc brightness-up"
        ", XF86MonBrightnessDown, exec, $noctipc brightness-down"
        ", XF86BrightnessUp, exec, $noctipc brightness-up"
        ", XF86BrightnessDown, exec, $noctipc brightness-down"
      ];

      bindl = [
        # Media
        ", XF86AudioPlay, exec, $noctipc media toggle"
        ", XF86AudioPause, exec, $noctipc media toggle"
        ", XF86AudioPrev, exec, $noctipc media previous"
        ", XF86AudioNext, exec, $noctipc media next"
        ", XF86AudioStop, exec, $noctipc media stop"

        # Audio
        ", XF86AudioMute, exec, $noctipc volume-mute"
        ", XF86AudioMicMute, exec, $noctipc mic-mute"
      ];
    };
  };
}
