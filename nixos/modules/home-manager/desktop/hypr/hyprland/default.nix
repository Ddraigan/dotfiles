{
  pkgs,
  inputs,
  lib,
  config,
  profileName,
  uwsmUtils,
  colours,
  ...
}: let
  cfg = config.modules.desktop.hypr.hyprland;
  sys = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    ./hosts/${profileName}.nix
  ];
  options.modules.desktop.hypr.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";
    mod = lib.mkOption {
      type = lib.types.str;
      example = "SUPER";
    };
  };

  config =
    lib.mkIf cfg.enable
    (let
      workspaces = lib.range 0 9;
      wsBindsCustom =
        lib.concatMap (i: [
          {
            keys = "$mod + ${toString i}";
            run = "hl.dsp.exec_cmd(\"split-workspaces ${toString i} focus\")";
          }
          {
            keys = "$mod + SHIFT + ${toString i}";
            run = "hl.dsp.exec_cmd(\"split-workspaces ${toString i} move\")";
          }
        ])
        workspaces;

      splitWorkspaces = pkgs.writeShellScriptBin "split-workspaces" ''
        WS=$1
        ACTION=$2

        if [ "$WS" -eq 0 ]; then WS=10; fi

        MONITOR=$(${pkgs.hyprland}/bin/hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq -r '.monitor')

        INDEX=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r 'sort_by(.id) | map(.name) | index("'"$MONITOR"'")')

        TARGET_WS=$(( WS + (INDEX * 10) ))

        if [ "$ACTION" == "focus" ]; then
            ${pkgs.hyprland}/bin/hyprctl dispatch workspace "$TARGET_WS"
        elif [ "$ACTION" == "move" ]; then
            ${pkgs.hyprland}/bin/hyprctl dispatch movetoworkspace "$TARGET_WS"
        fi
      '';

      mkBind = b: {_args = [b.keys (lib.generators.mkLuaInline b.run)];};
    in {
      xdg = {
        configFile = {
          "uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
        };
      };
      home = {
        packages = with pkgs; [
          # Colour Picker
          hyprpicker
          # Clipboard
          cliphist
          wl-clipboard

          # For media keys
          playerctl

          hyprsysteminfo

          # QT
          hyprland-qt-support

          # Screenshot Utils
          hyprshot
          grim
          slurp

          # Custom workspaces split
          jq
          splitWorkspaces
        ];
        sessionVariables = {
          NIXOS_XDG_OPEN_USE_PORTAL = "1";
          XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";
          XDG_PICTURES_DIR = "$HOME/Pictures";
          HYPRSHOT_DIR = "$HOME/Pictures/screenshots";
        };
      };
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        configType = "lua";
        package = inputs.hyprland.packages.${sys}.hyprland;
        portalPackage = null;
        systemd = {
          enable = false; # Being enabled would conflict with UWSM
          variables = [
            "--all"
          ];
        };
        plugins = [
          # inputs.hyprsplit.packages.${sys}.hyprsplit
          # inputs.hypr-darkwindow.packages.${sys}.Hypr-DarkWindow
        ];
        settings = {
          # "plugin:hyprsplit" = {
          #   num_workspaces = 9;
          #   bind =
          #     wsBindsSplit
          #     ++ [
          #       "$mod SHIFT, n, split:swapactiveworkspaces, current +1"
          #       "$mod SHIFT, W, split:movetoworkspace, special:magic"
          #     ];
          # };
          # "plugin:darkwindow:load_shaders" = "chromakey";
          # "plugin:darkwindow" = {
          #   windowrule = [
          #     "darkwindow:shade chromakey bkg=[0.0 0.0 0.0] targetOpacity=0.0, match:class spotify"
          #     "darkwindow:shade chromakey bkg=[0.255 0.255 0.255] targetOpacity=0.0, match:class com.github.wwmm.easyeffects"
          #   ];
          # };

          # Commands
          # "$exitCommand" = "${uwsmUtils.exit}";
          # "$copy" = "wl-copy";
          # "$paste" = "wl-paste";

          # Programs
          # "$terminal" = "${uwsmUtils.wrap "wezterm"}";
          # "$fileManager" = "${uwsmUtils.wrap "nemo"}";
          # "$drun" = "${uwsmUtils.rofi}";
          # "$browser" = "${uwsmUtils.wrap "zen-beta"}";

          # Utils
          # "$colourPicker" = "${uwsmUtils.wrap "hyprpicker -a"}";
          # "$lockScreen" = "${uwsmUtils.wrap "hyprlock"}";
          # "$sessionScreen" = "${uwsmUtils.wrap "wlogout"}";
          # "$screenshot" = "${uwsmUtils.wrap "hyprshot -m window"}";
          # "$screenshotRegion" = "${uwsmUtils.wrap "hyprshot -m region output --clipboard-only"}";

          # --- VARIABLES USING THE '_var' PROPERTY ---
          # Home Manager translates these into global Lua variables (e.g., mod = "SUPER")
          mod = {_var = cfg.mod;};
          LMB = {_var = "mouse:272";};
          RMB = {_var = "mouse:273";};

          exitCommand = {_var = "${uwsmUtils.exit}";};
          copy = {_var = "wl-copy";};
          paste = {_var = "wl-paste";};
          terminal = {_var = "${uwsmUtils.wrap "wezterm"}";};
          fileManager = {_var = "${uwsmUtils.wrap "nemo"}";};
          drun = {_var = "${uwsmUtils.rofi}";};
          browser = {_var = "${uwsmUtils.wrap "zen-beta"}";};
          colourPicker = {_var = "${uwsmUtils.wrap "hyprpicker -a"}";};
          lockScreen = {_var = "${uwsmUtils.wrap "hyprlock"}";};
          sessionScreen = {_var = "${uwsmUtils.wrap "wlogout"}";};
          screenshot = {_var = "${uwsmUtils.wrap "hyprshot -m window"}";};
          screenshotRegion = {_var = "${uwsmUtils.wrap "hyprshot -m region output --clipboard-only"}";};

          # --- LUA STARTUP HOOKS ---
          # Hyprland's Lua spec prefers event callbacks for startup execution
          on = {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline ''
                function()
                  hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
                  hl.exec_cmd("systemctl --user enable --now hypridle.service")
                  hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
                  hl.exec_cmd("nm-applet --indicator")
                  hl.exec_cmd("wl-paste --watch cliphist store &")
                  hl.exec_cmd(terminal) -- Uses the global variable declared above
                end
              '')
            ];
          };

          layer_rule = [
            "blur on, match:namespace rofi"
            "no_anim on, match:namespace dms"
          ];

          window_rule = [
            "suppress_event maximize, match:class .*"
            "float on, match:class org.quickshell"
            "float on, match:class blueman-manager"
            "float on, match:class yad"
            "float on, match:title Steam Settings"
          ];

          general = {
            border_size = 1;
            gaps_in = 5;
            gaps_out = 5;

            resize_on_border = true;
            allow_tearing = false;
            layout = "dwindle";

            "col.inactive_border" = colours.rgb.mantle;
            "col.active_border" = colours.rgb.pink;
          };

          decoration = {
            rounding = 0;
            active_opacity = 1.0;
            inactive_opacity = 1.0;
            shadow = {
              enabled = false;
              range = 30;
              render_power = 5;
              offset = "0 5";
              color = "rgba(00000070)";
            };
            blur = {
              enabled = true;
              size = 3;
              passes = 2;
              new_optimizations = true;
              xray = true;
              ignore_opacity = true;
              brightness = 0.3;
            };
          };

          curve = {
            _args = [
              "overshoot"
              {
                type = "bezier";
                points = [[0.13 0.99] [0.29 1.1]];
              }
            ];
          };
          animation = [
            {
              _args = [
                {
                  leaf = "windows";
                  enabled = true;
                  speed = 4;
                  bezier = "overshoot";
                  style = "slide";
                }
              ];
            }
            {
              _args = [
                {
                  leaf = "border";
                  enabled = true;
                  speed = 10;
                  bezier = "default";
                }
              ];
            }
            {
              _args = [
                {
                  leaf = "fade";
                  enabled = true;
                  speed = 10;
                  bezier = "default";
                }
              ];
            }
            {
              _args = [
                {
                  leaf = "workspaces";
                  enabled = true;
                  speed = 6;
                  bezier = "default";
                  style = "fade";
                }
              ];
            }
            {
              _args = [
                {
                  leaf = "specialWorkspace";
                  enabled = true;
                  speed = 6;
                  bezier = "default";
                  style = "fade";
                }
              ];
            }
          ];

          dwindle = {
            preserve_split = true;
            special_scale_factor = 0.8;
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
          };

          input = {
            kb_layout = "us";

            follow_mouse = 1;
            sensitivity = 0;
          };

          # 1. Standard Binds (hl.bind)
          bind = map mkBind (wsBindsCustom
            ++ [
              {
                keys = "$mod + p";
                run = "hl.dsp.exec_cmd(colourPicker)";
              }
              {
                keys = "$mod + escape";
                run = "hl.dsp.exec_cmd(sessionScreen)";
              }
              {
                keys = "$mod + i";
                run = "hl.dsp.exec_cmd(screenshotRegion)";
              }
              {
                keys = "$mod + SHIFT + I";
                run = "hl.dsp.exec_cmd(screenshot)";
              }
              {
                keys = "PRINT";
                run = "hl.dsp.exec_cmd(screenshot)";
              }
              {
                keys = "$mod + C";
                run = "hl.dsp.exec_cmd(copy)";
              }
              {
                keys = "$mod + D";
                run = "hl.dsp.exec_cmd(drun)";
              }
              {
                keys = "$mod + B";
                run = "hl.dsp.exec_cmd(browser)";
              }
              {
                keys = "$mod + T";
                run = "hl.dsp.exec_cmd(terminal)";
              }
              {
                keys = "$mod + F";
                run = "hl.dsp.exec_cmd(fileManager)";
              }

              {
                keys = "$mod + SHIFT + X";
                run = "hl.dsp.exec_cmd(exitCommand)";
              }
              {
                keys = "$mod + SHIFT + Q";
                run = "hl.dsp.killactive()";
              }
              {
                keys = "$mod + SHIFT + F";
                run = "hl.dsp.fullscreen()";
              }
              {
                keys = "$mod + SHIFT + Z";
                run = "hl.dsp.togglefloating()";
              }
              {
                keys = "$mod + SHIFT + P";
                run = "hl.dsp.pseudo()";
              }
              {
                keys = "$mod + SHIFT + S";
                run = "hl.dsp.layoutmsg(\"togglesplit\")";
              }

              # Focus Directionals
              {
                keys = "$mod + left";
                run = "hl.dsp.movefocus(\"l\")";
              }
              {
                keys = "$mod + right";
                run = "hl.dsp.movefocus(\"r\")";
              }
              {
                keys = "$mod + up";
                run = "hl.dsp.movefocus(\"u\")";
              }
              {
                keys = "$mod + down";
                run = "hl.dsp.movefocus(\"d\")";
              }
              {
                keys = "$mod + h";
                run = "hl.dsp.movefocus(\"l\")";
              }
              {
                keys = "$mod + l";
                run = "hl.dsp.movefocus(\"r\")";
              }
              {
                keys = "$mod + k";
                run = "hl.dsp.movefocus(\"u\")";
              }
              {
                keys = "$mod + j";
                run = "hl.dsp.movefocus(\"d\")";
              }

              # Window Moving Directionals
              {
                keys = "$mod + SHIFT + H";
                run = "hl.dsp.movewindow(\"l\")";
              }
              {
                keys = "$mod + SHIFT + L";
                run = "hl.dsp.movewindow(\"r\")";
              }
              {
                keys = "$mod + SHIFT + K";
                run = "hl.dsp.movewindow(\"u\")";
              }
              {
                keys = "$mod + SHIFT + J";
                run = "hl.dsp.movewindow(\"d\")";
              }

              {
                keys = "$mod + W";
                run = "hl.dsp.togglespecialworkspace(\"magic\")";
              }

              # Touchpad rules
              {
                keys = "XF86TouchpadToggle";
                run = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled toggle\")";
              }
              {
                keys = "XF86TouchpadOn";
                run = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled true\")";
              }
              {
                keys = "XF86TouchpadOff";
                run = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled false\")";
              }

              # Noctipc Integrations
              {
                keys = "SUPER + D";
                run = "hl.dsp.exec_cmd(\"$noctipc panel-toggle launcher\")";
              }
              {
                keys = "SUPER + S";
                run = "hl.dsp.exec_cmd(\"$noctipc panel-toggle control-center\")";
              }
              {
                keys = "SUPER + comma";
                run = "hl.dsp.exec_cmd(\"$noctipc settings-toggle\")";
              }
            ]);

          # 2. Repeatable Binds (hl.binde)
          binde = map mkBind [
            {
              keys = "$mod + ALT + H";
              run = "hl.dsp.resizeactive(-10, 0)";
            }
            {
              keys = "$mod + ALT + L";
              run = "hl.dsp.resizeactive(10, 0)";
            }
            {
              keys = "$mod + ALT + K";
              run = "hl.dsp.resizeactive(0, -10)";
            }
            {
              keys = "$mod + ALT + J";
              run = "hl.dsp.resizeactive(0, 10)";
            }
          ];

          # 3. Locked/Repeatable Binds (hl.bindel)
          bindel = map mkBind [
            {
              keys = "XF86KbdBrightnessUp";
              run = "hl.dsp.exec_cmd(\"brightnessctl -d *kbd* set +5%\")";
            }
            {
              keys = "XF86KbdBrightnessDown";
              run = "hl.dsp.exec_cmd(\"brightnessctl -d *kbd* set 5%-\")";
            }
            {
              keys = "XF86AudioRaiseVolume";
              run = "hl.dsp.exec_cmd(\"$noctipc volume-up\")";
            }
            {
              keys = "XF86AudioLowerVolume";
              run = "hl.dsp.exec_cmd(\"$noctipc volume-down\")";
            }
            {
              keys = "XF86AudioVolumeUp";
              run = "hl.dsp.exec_cmd(\"$noctipc volume-up\")";
            }
            {
              keys = "XF86AudioVolumeDown";
              run = "hl.dsp.exec_cmd(\"$noctipc volume-down\")";
            }
            {
              keys = "XF86MonBrightnessUp";
              run = "hl.dsp.exec_cmd(\"$noctipc brightness-up\")";
            }
            {
              keys = "XF86MonBrightnessDown";
              run = "hl.dsp.exec_cmd(\"$noctipc brightness-down\")";
            }
            {
              keys = "XF86BrightnessUp";
              run = "hl.dsp.exec_cmd(\"$noctipc brightness-up\")";
            }
            {
              keys = "XF86BrightnessDown";
              run = "hl.dsp.exec_cmd(\"$noctipc brightness-down\")";
            }
          ];

          # 4. Locked Binds (hl.bindl)
          bindl = map mkBind [
            {
              keys = "XF86AudioPlay";
              run = "hl.dsp.exec_cmd(\"$noctipc media toggle\")";
            }
            {
              keys = "XF86AudioPause";
              run = "hl.dsp.exec_cmd(\"$noctipc media toggle\")";
            }
            {
              keys = "XF86AudioPrev";
              run = "hl.dsp.exec_cmd(\"$noctipc media previous\")";
            }
            {
              keys = "XF86AudioNext";
              run = "hl.dsp.exec_cmd(\"$noctipc media next\")";
            }
            {
              keys = "XF86AudioStop";
              run = "hl.dsp.exec_cmd(\"$noctipc media stop\")";
            }
            {
              keys = "XF86AudioMute";
              run = "hl.dsp.exec_cmd(\"$noctipc volume-mute\")";
            }
            {
              keys = "XF86AudioMicMute";
              run = "hl.dsp.exec_cmd(\"$noctipc mic-mute\")";
            }
          ];

          # 5. Mouse Binds (hl.bindm)
          bindm = map mkBind [
            {
              keys = "$mod + SHIFT + $LMB";
              run = "hl.dsp.movewindow()";
            }
            {
              keys = "$mod + ALT + $LMB";
              run = "hl.dsp.resizewindow()";
            }
          ];
        };
      };
    });
}
# l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active
# r -> release, will trigger on release of a key
# e -> repeat, will repeat when held
# n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher
# m -> mouse, see below
# t -> transparent, cannot be shadowed by other binds
# i -> ignore mods, will ignore modifiers.

