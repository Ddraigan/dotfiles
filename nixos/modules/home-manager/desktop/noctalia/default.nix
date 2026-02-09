{pkgs, inputs, lib, config, colours, ...}:
let
cfg = config.modules.desktop.noctalia;
in 
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.modules.desktop.noctalia = {
    enable = lib.mkEnableOption "Enable Noctalia Shell";
  };
  config = lib.mkIf cfg.enable {
    programs.noctalia-shell ={
      enable = true;
      plugins = {
        sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
        ];
        states = {
          catwalk = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 1;
      };
      colors = let
        hex = colours.hex;
      in  {
        mError = hex.red;
        mOnError = hex.text;
        mOnPrimary = hex.text;
        mOnSecondary = hex.text;
        mOnSurface = hex.text;
        mOnSurfaceVariant = hex.text;
        mOnTertiary = hex.text;
        mOnHover = hex.text;
        mOutline = hex.crust;
        mPrimary = hex.mauve;
        mSecondary = hex.maroon;
        mShadow = hex.crust;
        mSurface = hex.surface0;
        mHover = hex.base;
        mSurfaceVariant = hex.surface3;
        mTertiary = hex.pink;
      };
    };
    wayland.windowManager.hyprland.settings = {
      exec-once = [
          "systemctl --user enable --now noctalia.service"
      ];

      "$noctipc = noctalia-shell ipc call";

      bind = [ 
        "SUPER, SPACE, exec, $noctipc launcher toggle"
        "SUPER, S, exec, $noctipc controlCenter toggle"
        "SUPER, comma, exec, $noctipc settings toggle" 
      ];

      bindel = [
        # Media
        ", XF86AudioRaiseVolume, exec, $noctipc volume increase"
        ", XF86AudioLowerVolume, exec, $noctipc volume decrease"

        # Brightness
        ", XF86MonBrightnessUp, exec, $noctipc brightness increase"
        ", XF86MonBrightnessDown, exec, $noctipc brightness decrease"
      ];

      bindl = [
        # Media
        ", XF86AudioMute, exec, $noctipc volume muteOutput"
        ", XF86AudioPlay, exec, $noctipc media play"
        ", XF86AudioPrev, exec, $noctipc media previous"
        ", XF86AudioNext, exec, $noctipc media next"
      ];
    };
  };
}
