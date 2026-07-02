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
    wayland.windowManager.hyprland.settings = let
      mod = config.modules.desktop.hypr.hyprland.mod;
      noctipc = "nactalia msg";
      mkBind = b: {
        _args = [
          (lib.generators.mkLuaInline b.keys)
          (lib.generators.mkLuaInline b.cmd)
        ];
      };
    in {
      bind = map mkBind [
        {
          keys = "${mod} + D";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} panel-toggle launcher\")";
        }
        {
          keys = "${mod} + S";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} panel-toggle control-center\")";
        }
        {
          keys = "${mod} + comma";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} settings-toggle\")";
        }
      ];

      bindel = map mkBind [
        {
          keys = "XF86AudioRaiseVolume";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} volume-up\")";
        }
        {
          keys = "XF86AudioLowerVolume";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} volume-down\")";
        }
        {
          keys = "XF86AudioVolumeUp";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} volume-up\")";
        }
        {
          keys = "XF86AudioVolumeDown";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} volume-down\")";
        }
        {
          keys = "XF86MonBrightnessUp";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} brightness-up\")";
        }
        {
          keys = "XF86MonBrightnessDown";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} brightness-down\")";
        }
        {
          keys = "XF86BrightnessUp";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} brightness-up\")";
        }
        {
          keys = "XF86BrightnessDown";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} brightness-down\")";
        }
      ];

      bindl = map mkBind [
        {
          keys = "XF86AudioPlay";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} media toggle\")";
        }
        {
          keys = "XF86AudioPause";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} media toggle\")";
        }
        {
          keys = "XF86AudioPrev";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} media previous\")";
        }
        {
          keys = "XF86AudioNext";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} media next\")";
        }
        {
          keys = "XF86AudioStop";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} media stop\")";
        }
        {
          keys = "XF86AudioMute";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} volume-mute\")";
        }
        {
          keys = "XF86AudioMicMute";
          cmd = "hl.dsp.exec_cmd(\"${noctipc} mic-mute\")";
        }
      ];
    };
  };
}
