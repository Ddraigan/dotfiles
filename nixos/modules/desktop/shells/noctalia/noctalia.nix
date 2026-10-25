{...}: {
  homeManager.noctalia = {
    inputs,
    pkgs,
    lib,
    config,
    colours,
    ...
  }: let
    mod = config.modules.desktop.hypr.hyprland.mod or "SUPER";
    noctipc = "noctalia msg";

    noctaliaBinds = [
      {
        keys = "${mod}+D";
        cmd = "${noctipc} panel-toggle launcher";
      }
      {
        keys = "${mod}+S";
        cmd = "${noctipc} panel-toggle control-center";
      }
      {
        keys = "${mod}+comma";
        cmd = "${noctipc} settings-toggle";
      }
      {
        keys = "XF86AudioRaiseVolume";
        cmd = "${noctipc} volume-up";
        repeating = true;
        locked = true;
      }
      {
        keys = "XF86AudioLowerVolume";
        cmd = "${noctipc} volume-down";
        repeating = true;
        locked = true;
      }
      {
        keys = "XF86MonBrightnessUp";
        cmd = "${noctipc} brightness-up";
        repeating = true;
        locked = true;
      }
      {
        keys = "XF86MonBrightnessDown";
        cmd = "${noctipc} brightness-down";
        repeating = true;
        locked = true;
      }
      {
        keys = "XF86AudioPlay";
        cmd = "${noctipc} media toggle";
        locked = true;
      }
      {
        keys = "XF86AudioPause";
        cmd = "${noctipc} media toggle";
        locked = true;
      }
      {
        keys = "XF86AudioPrev";
        cmd = "${noctipc} media previous";
        locked = true;
      }
      {
        keys = "XF86AudioNext";
        cmd = "${noctipc} media next";
        locked = true;
      }
      {
        keys = "XF86AudioStop";
        cmd = "${noctipc} media stop";
        locked = true;
      }
      {
        keys = "XF86AudioMute";
        cmd = "${noctipc} volume-mute";
        locked = true;
      }
      {
        keys = "XF86AudioMicMute";
        cmd = "${noctipc} mic-mute";
        locked = true;
      }
    ];

    mkHyprBind = b: {
      _args = [
        (builtins.replaceStrings ["+"] [" + "] b.keys)
        (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"${b.cmd}\")")
        (
          lib.optionalAttrs (b ? repeating || b ? locked) {
            repeating = b.repeating or false;
            locked = b.locked or false;
          }
        )
      ];
    };

    mkUmbrielBind = builtins.listToAttrs (
      map (b: {
        name = b.keys;
        value = "spawn:${b.cmd}";
      })
      noctaliaBinds
    );
  in {
    config = lib.mkMerge [
      {
        programs.noctalia = {
          enable = true;
          systemd.enable = true;
          settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
        };
      }

      (lib.mkIf (config.wayland.windowManager.hyprland.enable or false) {
        wayland.windowManager.hyprland.settings = {
          bind = map mkHyprBind noctaliaBinds;
        };
      })

      (lib.mkIf (config.programs.umbriel.enable or false) {
        programs.umbriel.settings.keybinds = mkUmbrielBind;
      })
    ];
  };
}
