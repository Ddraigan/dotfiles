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
      mod = cfg.mod;
      lmb = "mouse:272";
      rmb = "mouse:273";
      workspaces = lib.range 0 9;
      wsBindsCustom =
        lib.concatMap (i: [
          {
            keys = "${mod} + ${toString i}";
            cmd = "hl.dsp.exec_cmd(\"split-workspaces ${toString i} focus\")";
          }
          {
            keys = "${mod} + SHIFT + ${toString i}";
            cmd = "hl.dsp.exec_cmd(\"split-workspaces ${toString i} move\")";
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

      mkBind = {
        keys,
        cmd,
        flag ? {},
      }: {
        _args = [
          "${keys}"
          (lib.generators.mkLuaInline "${cmd}")
          flag
        ];
      };
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
          #       "${mod} SHIFT, n, split:swapactiveworkspaces, current +1"
          #       "${mod} SHIFT, W, split:movetoworkspace, special:magic"
          #     ];
          # };
          # "plugin:darkwindow:load_shaders" = "chromakey";
          # "plugin:darkwindow" = {
          #   windowrule = [
          #     "darkwindow:shade chromakey bkg=[0.0 0.0 0.0] targetOpacity=0.0, match:class spotify"
          #     "darkwindow:shade chromakey bkg=[0.255 0.255 0.255] targetOpacity=0.0, match:class com.github.wwmm.easyeffects"
          #   ];
          # };

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

          on = {
            _args = [
              "hyprland.start"
              (lib.generators.mkLuaInline
                #lua
                ''
                  function()
                    hl.exec_cmd("systemctl --user enable --now hyprpolkitagent.service")
                    hl.exec_cmd("systemctl --user enable --now hypridle.service")
                    hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
                    hl.exec_cmd("nm-applet --indicator")
                    hl.exec_cmd("wl-paste --watch cliphist store &")
                    hl.exec_cmd(terminal)
                  end
                '')
            ];
          };

          config = {
            layer_rule = [
              "blur on, match:namespace rofi"
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
          };

          bind = map mkBind (wsBindsCustom
            ++ [
              {
                keys = "${mod} + p";
                cmd = "hl.dsp.exec_cmd(colourPicker)";
              }
              {
                keys = "${mod} + escape";
                cmd = "hl.dsp.exec_cmd(sessionScreen)";
              }
              {
                keys = "${mod} + i";
                cmd = "hl.dsp.exec_cmd(screenshotRegion)";
              }
              {
                keys = "${mod} + SHIFT + I";
                cmd = "hl.dsp.exec_cmd(screenshot)";
              }
              {
                keys = "PRINT";
                cmd = "hl.dsp.exec_cmd(screenshot)";
              }
              {
                keys = "${mod} + C";
                cmd = "hl.dsp.exec_cmd(copy)";
              }
              {
                keys = "${mod} + D";
                cmd = "hl.dsp.exec_cmd(drun)";
              }
              {
                keys = "${mod} + B";
                cmd = "hl.dsp.exec_cmd(browser)";
              }
              {
                keys = "${mod} + T";
                cmd = "hl.dsp.exec_cmd(terminal)";
              }
              {
                keys = "${mod} + F";
                cmd = "hl.dsp.exec_cmd(fileManager)";
              }
              {
                keys = "${mod} + SHIFT + X";
                cmd = "hl.dsp.exec_cmd(exitCommand)";
              }
              {
                keys = "${mod} + SHIFT + Q";
                cmd = "hl.dsp.window.close({window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + F";
                cmd = "hl.dsp.window.fullscreen()";
              }
              {
                keys = "${mod} + SHIFT + Z";
                cmd = "hl.dsp.window.float({action = \"toggle\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + P";
                cmd = "hl.dsp.window.pseudo({action = \"toggle\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + S";
                cmd = "hl.dsp.layout(\"togglesplit\")";
              }
              # Focus Directionals
              {
                keys = "${mod} + left";
                cmd = "hl.dsp.focus({direction = \"l\"})";
              }
              {
                keys = "${mod} + right";
                cmd = "hl.dsp.focus({direction = \"r\"})";
              }
              {
                keys = "${mod} + up";
                cmd = "hl.dsp.focus({direction = \"u\"})";
              }
              {
                keys = "${mod} + down";
                cmd = "hl.dsp.focus({direction = \"d\"})";
              }
              {
                keys = "${mod} + h";
                cmd = "hl.dsp.focus({direction = \"l\"})";
              }
              {
                keys = "${mod} + l";
                cmd = "hl.dsp.focus({direction = \"r\"})";
              }
              {
                keys = "${mod} + k";
                cmd = "hl.dsp.focus({direction = \"u\"})";
              }
              {
                keys = "${mod} + j";
                cmd = "hl.dsp.focus({direction = \"d\"})";
              }
              # Window Moving Directionals
              {
                keys = "${mod} + SHIFT + H";
                cmd = "hl.dsp.window.move({direction = \"l\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + L";
                cmd = "hl.dsp.window.move({direction = \"r\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + K";
                cmd = "hl.dsp.window.move({direction = \"u\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + SHIFT + J";
                cmd = "hl.dsp.window.move({direction = \"d\", window = \"activewindow\"})";
              }
              {
                keys = "${mod} + W";
                cmd = "hl.dsp.workspace.toggle_special(\"magic\")";
              }
              # Window Resizing
              {
                keys = "${mod} + ALT + H";
                cmd = "hl.dsp.window.resize({ x = -10, y = 0, window = \"activewindow\" })";
                flag = {repeating = true;};
              }
              {
                keys = "${mod} + ALT + L";
                cmd = "hl.dsp.window.resize({ x = 10, y = 0, window = \"activewindow\" })";
                flag = {repeating = true;};
              }
              {
                keys = "${mod} + ALT + K";
                cmd = "hl.dsp.window.resize({ x = 0, y = -10, window = \"activewindow\" })";
                flag = {repeating = true;};
              }
              {
                keys = "${mod} + ALT + J";
                cmd = "hl.dsp.window.resize({ x = 0, y = 10, window = \"activewindow\" })";
                flag = {repeating = true;};
              }
              # Touchpad
              {
                keys = "XF86TouchpadToggle";
                cmd = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled toggle\")";
              }
              {
                keys = "XF86TouchpadOn";
                cmd = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled true\")";
              }
              {
                keys = "XF86TouchpadOff";
                cmd = "hl.dsp.exec_cmd(\"hyprctl keyword device:*:enabled false\")";
              }
              {
                keys = "${mod} + SHIFT + ${lmb}";
                cmd = "hl.dsp.window.drag()";
                flag = {mouse = true;};
              }
              {
                keys = "${mod} + ALT + ${lmb}";
                cmd = "hl.dsp.window.resize()";
                flag = {mouse = true;};
              }
            ]);
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

