{
  pkgs,
  inputs,
  lib,
  config,
  profileName,
  uwsmUtils,
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
    # uwsm = lib.mkEnableOption "Use UWSM?";
    # dms = lib.mkEnableOption "Use DMS?";
  };

  config =
    lib.mkIf cfg.enable
    (let
      workspaces = lib.range 1 9;
      wsBinds =
        lib.concatMap (i: [
          "$mod, ${toString i}, split:workspace, ${toString i}"
          "$mod SHIFT, ${toString i}, split:movetoworkspace, ${toString i}"
        ])
        workspaces;
    in {
      home.packages = with pkgs; [
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
        inputs.hyprqt6engine.packages.${sys}.default

        # Screenshot Utils
        hyprshot
        grim
        slurp
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        # package = null;
        package = inputs.hyprland.packages.${sys}.hyprland;
        # portalPackage = "";
        systemd = {
          enable = false; # Being enabled would conflict with UWSM
          variables = [
            "--all"
            # "DISPLAY"
            # "HYPRLAND_INSTANCE_SIGNATURE"
            # "WAYLAND_DISPLAY"
            # "XDG_CURRENT_DESKTOP"
            # "QT_QPA_PLATFORM"
          ];
        };
        plugins = [
          inputs.hyprsplit.packages.${sys}.hyprsplit
          inputs.hypr-darkwindow.packages.${sys}.Hypr-DarkWindow
        ];
        settings =
          {
            "plugin:hyprsplit" = {
              num_workspaces = 9;
              bind =
                wsBinds
                ++ [
                  "$mod SHIFT, n, split:swapactiveworkspaces, current +1"
                  "$mod SHIFT, W, split:movetoworkspace, special:magic"
                ];
            };
            "plugin:darkwindow:load_shaders" = "chromakey";
            "plugin:darkwindow" = {
              windowrule = [
                "darkwindow:shade chromakey bkg=[0.0 0.0 0.0] targetOpacity=0.0, match:class spotify"
                "darkwindow:shade chromakey bkg=[0.255 0.255 0.255] targetOpacity=0.0, match:class com.github.wwmm.easyeffects"
              ];
            };

            # Commands
            "$exitCommand" = "${uwsmUtils.exit}";
            "$copy" = "wl-copy";
            "$paste" = "wl-paste";

            # Programs
            "$terminal" = "${uwsmUtils.wrap "wezterm"}";
            "$fileManager" = "${uwsmUtils.wrap "nemo"}";
            "$drun" = "${uwsmUtils.rofi}";
            "$browser" = "${uwsmUtils.wrap "zen"}";

            # Utils
            "$colourPicker" = "${uwsmUtils.wrap "hyprpicker -a"}";
            # "$lockScreen" = "${uwsmUtils.wrap "hyprlock"}";
            "$screenshot" = "${uwsmUtils.wrap "hyprshot -m window"}";
            "$screenshotRegion" = "${uwsmUtils.wrap "hyprshot -m region output --clipboard-only"}";

            env = [
              "XDG_SCREENSHOTS_DIR,$HOME/Pictures/screenshots"
              "XDG_PICTURES_DIR,$HOME/Pictures"
              "HYPRSHOT_DIR,$HOME/Pictures/screenshots"

              # When using hyprqt6engine over qt6ct
              "QT_QPA_PLATFORMTHEME=hyprqt6engine"
            ];

            exec-once = [
              "systemctl --user enable --now hyprpolkitagent.service"
              "systemctl --user enable --now hypridle.service"
              "systemctl --user enable --now hyprpaper.service"
              "systemctl --user enable --now dms.service"
              "nm-applet --indicator"
              "wl-paste --watch cliphist store &"
              "$terminal"
            ];

            layerrule = [
              "blur on, match:namespace rofi"
              "no_anim on, match:namespace dms"
            ];

            windowrule = [
              "suppress_event maximize, match:class .*"
              "float on, match:class org.quickshell"
              "float on, match:class gnome-calculator"
              "float on, match:class blueman-manager"
            ];

            general = {
              border_size = 1;
              gaps_in = 5;
              gaps_out = 5;

              resize_on_border = true;
              allow_tearing = false;
              layout = "dwindle";

              "col.inactive_border" = "$mantle";
              "col.active_border" = "$pink";
            };

            decoration = {
              rounding = 12;
              active_opacity = 1.0;
              inactive_opacity = 0.9;
              shadow = {
                enabled = true;
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

            animations = {
              enabled = true;
              bezier = "overshot,0.13,0.99,0.29,1.1";
              animation = [
                "windows         , 1,  4, overshot, slide"
                "border          , 1, 10, default"
                "fade            , 1, 10, default"
                "workspaces      , 1,  6, default , fade"
                "specialWorkspace, 1,  6, default , fade"
              ];
            };

            dwindle = {
              pseudotile = true;
              preserve_split = true;
              special_scale_factor = 0.8;
            };

            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
            };

            # monitorv2 = [
            #   {
            #     output = "DP-1";
            #     mode = "preferred";
            #     position = "0x0";
            #     scale = 1;
            #     bitdepth = 8;
            #   }
            #   {
            #     output = "DP-2";
            #     mode = "preferred";
            #     position = "auto-left";
            #     scale = "auto";
            #     bitdepth = 8;
            #   }
            # ];

            input = {
              kb_layout = "us";
              # kb_variant = "dvorak";

              follow_mouse = 1;
              sensitivity = 0;
            };

            "$mod" = cfg.mod;
            "$LMB" = "mouse:272";
            "$RMB" = "mouse:273";

            bindel = [
              # ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"
              # ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"

              # DMS
              # Audio Controls
              ", XF86AudioRaiseVolume, exec, dms ipc call audio increment 2"
              ", XF86AudioLowerVolume, exec, dms ipc call audio decrement 2"
              # Brightness Controls
              ", XF86MonBrightnessUp, exec, dms ipc call brightness increment 5"
              ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
            ];
            bindl = [
              # ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ", XF86AudioPlay, exec, playerctl play-pause"
              ", XF86AudioPrev, exec, playerctl previous"
              ", XF86AudioNext, exec, playerctl next"

              # DMS
              ", XF86AudioMute, exec, dms ipc call audio mute"
            ];
            binde = [
              # Vim Style Window Resize
              "$mod ALT, H, resizeactive, -10 0"
              "$mod ALT, L, resizeactive, 10 0"
              "$mod ALT, K, resizeactive, 0 -10"
              "$mod ALT, J, resizeactive, 0 10"
            ];
            bindm = [
              "$mod SHIFT, $LMB, movewindow"
              "$mod ALT, $LMB, resizewindow"
            ];
            bind = [
              # "$mod, TAB, overview:toggle"
              # "$mod, Tab, hyprexpo:expo, toggle"
              "$mod, p, exec, $colourPicker"

              "$mod, escape, exec, uwsm app -- wlogout"
              # "$mod, l, exec, $lockscreen"

              # Clipboard
              "$mod, i, exec, $screenshotRegion"
              "$mod SHIFT, I, exec, $screenshot"
              ", PRINT, exec, $screenshot"
              # "$mod, V, exec, $paste"
              "$mod, C, exec, $copy"

              "$mod, D, exec, $drun"
              "$mod, B, exec, $browser"
              "$mod, T, exec, $terminal"
              "$mod, F, exec, $fileManager"

              # "$mod SHIFT, X, exit"
              "$mod SHIFT, X, exec, $exitCommand"
              "$mod SHIFT, Q, killactive"
              "$mod SHIFT, F, fullscreen"
              "$mod SHIFT, Z, togglefloating"
              "$mod SHIFT, P, pseudo"
              "$mod SHIFT, S, togglesplit"

              # Window Focus
              "$mod, left, movefocus, l"
              "$mod, right, movefocus, r"
              "$mod, up, movefocus, u"
              "$mod, down, movefocus, d"

              # Vim Style Window Focus
              "$mod, h, movefocus, l"
              "$mod, l, movefocus, r"
              "$mod, k, movefocus, u"
              "$mod, j, movefocus, d"

              # Vim Window Movement
              "$mod SHIFT, H, movewindow, l"
              "$mod SHIFT, L, movewindow, r"
              "$mod SHIFT, K, movewindow, u"
              "$mod SHIFT, J, movewindow, d"

              "$mod, W, togglespecialworkspace, magic"

              # DMS
              # Application Launchers
              "$mod, space, exec, dms ipc call spotlight toggle"
              "$mod, V, exec, dms ipc call clipboard toggle"
              "$mod, M, exec, dms ipc call processlist focusOrToggle"
              "$mod, comma, exec, dms ipc call settings focusOrToggle"
              "$mod, N, exec, dms ipc call notifications toggle"
              "$mod, Y, exec, dms ipc call dankdash wallpaper"
              "$mod, TAB, exec, dms ipc call hypr toggleOverview"
              # Security
              "$mod ALT, L, exec, dms ipc call lock lock"

              "$mod, a, exec, dms ipc call audio cycleoutput"
            ];
          }
          // import ./mocha.nix {};
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

