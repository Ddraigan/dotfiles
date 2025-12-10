{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.desktop.hypr.hyprland;
in {
  options = {
    modules.desktop.hypr.hyprland = {
      enable = lib.mkEnableOption "Enable Hyprland";
      uwsm = lib.mkEnableOption "Use UWSM?";
    };
  };

  config =
    lib.mkIf cfg.enable
    (let
      maybeWrapUWSMApp = cmd:
        if cfg.uwsm
        then "uwsm app -- ${cmd}"
        else cmd;

      maybeUWSMExit =
        if cfg.uwsm
        then "uwsm stop"
        else "exit";

      maybeUWSMRofi =
        if cfg.uwsm
        then "rofi -show drun -run-command 'uwsm app -- {cmd}'"
        else "rofi -show -drun";
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
        inputs.hyprqt6engine.packages.${pkgs.stdenv.hostPlatform.system}.default

        # Screenshot Utils
        hyprshot
        grim
        slurp
      ];
      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        # package = null;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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
          inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
        ];
        settings =
          {
            "plugin:hyprsplit" = {
              num_workspaces = 9;
              bind = [
                "$mod, 1, split:workspace, 1"
                "$mod, 2, split:workspace, 2"
                "$mod, 3, split:workspace, 3"
                "$mod, 4, split:workspace, 4"
                "$mod, 5, split:workspace, 5"
                "$mod, 6, split:workspace, 6"
                "$mod, 7, split:workspace, 7"
                "$mod, 8, split:workspace, 8"
                "$mod, 9, split:workspace, 9"

                "$mod SHIFT, 1, split:movetoworkspace, 1"
                "$mod SHIFT, 2, split:movetoworkspace, 2"
                "$mod SHIFT, 3, split:movetoworkspace, 3"
                "$mod SHIFT, 4, split:movetoworkspace, 4"
                "$mod SHIFT, 5, split:movetoworkspace, 5"
                "$mod SHIFT, 6, split:movetoworkspace, 6"
                "$mod SHIFT, 7, split:movetoworkspace, 7"
                "$mod SHIFT, 8, split:movetoworkspace, 8"
                "$mod SHIFT, 9, split:movetoworkspace, 9"
                "$mod SHIFT, 0, split:movetoworkspace, 0"

                "$mod SHIFT, n, split:swapactiveworkspaces, current +1"
                "$mod SHIFT, W, split:movetoworkspace, special:magic"
              ];
            };

            # Commands
            "$exitCommand" = "${maybeUWSMExit}";
            "$copy" = "wl-copy";
            "$paste" = "wl-paste";

            # Programs
            "$terminal" = "${maybeWrapUWSMApp "wezterm"}";
            "$fileManager" = "${maybeWrapUWSMApp "nemo"}";
            "$drun" = "${maybeUWSMRofi}";
            "$browser" = "${maybeWrapUWSMApp "zen"}";

            # Utils
            "$colourPicker" = "${maybeWrapUWSMApp "hyprpicker -a"}";
            "$lockScreen" = "${maybeWrapUWSMApp "hyprlock"}";
            "$screenshot" = "${maybeWrapUWSMApp "hyprshot -m window"}";
            "$screenshotRegion" = "${maybeWrapUWSMApp "hyprshot -m region output --clipboard-only"}";

            env = [
              "XDG_SCREENSHOTS_DIR,$HOME/Pictures/screenshots"
              "XDG_PICTURES_DIR,$HOME/Pictures"
              "HYPRSHOT_DIR,$HOME/Pictures/screenshots"

              # When using hyprqt6engine over qt6ct
              "QT_QPA_PLATFORMTHEME=hyprqt6engine"
            ];

            exec-once = [
              "systemctl --user enable --now hyprpolkitagent.service"
              "systemctl --user enable --now hypridle.service" # To start hypridle at launch with uwsm
              "systemctl --user enable --now hyprpaper.service"
              "systemctl --user enable --now waybar.service"
              # "systemctl --user enable --now dms.service"
              "nm-applet --indicator"
              "wl-paste --watch cliphist store"
              "$terminal"
            ];

            windowrule = [
              "suppress_event maximize, match:class .*"
              # "opacity 0.8, match:class ^(spotify)$"

              #   # All this stuff hides the xwaylandbridge window
              #   "opacity 0.0 override, match:class ^(xwaylandvideobridge)$"
              #   "no_initial_focus, match:class ^(xwaylandvideobridge)$"
              #   "maxsize 1 1, match:class ^(xwaylandvideobridge)$"
              #   "no_anim, match:class ^(xwaylandvideobridge)$"
              #   "no_blur, match:class ^(xwaylandvideobridge)$"
              #   "no_focus, match:class ^(xwaylandvideobridge)$"
            ];

            general = {
              border_size = 2;
              gaps_in = 5;
              gaps_out = 20;
              resize_on_border = true;
              allow_tearing = false;
              layout = "dwindle";

              "col.inactive_border" = "$mantle";
              "col.active_border" = "$pink";
            };

            decoration = {
              rounding = 10;
              active_opacity = 1.0;
              inactive_opacity = 1.0;
              shadow = {
                enabled = true;
                range = 4;
                render_power = 3;
                color = "rgba(1a1a1aee)";
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

            monitor = [
              "DP-1, preferred, 0x0, 1"
              "DP-2, preferred, auto-left, auto"
            ];

            # monitorv2 = [
            #   {
            #     output = "DP-1";
            #     mode = "preferred";
            #     position = "0x0";
            #     scale = 1;
            #   }
            #   {
            #     output = "DP-2";
            #     mode = "preferred";
            #     position = "auto-left";
            #     scale = "auto";
            #   }
            # ];

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

            input = {
              kb_layout = "us";
              kb_variant = "";

              follow_mouse = 1;
              sensitivity = 0;
              touchpad = {
                natural_scroll = true;
              };
            };

            gestures = {
              workspace = true;
            };

            "$mod" = "SUPER";
            "$LMB" = "mouse:272";
            "$RMB" = "mouse:273";

            # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
            # r -> release, will trigger on release of a key.
            # e -> repeat, will repeat when held.
            # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
            # m -> mouse, see below
            # t -> transparent, cannot be shadowed by other binds.
            # i -> ignore mods, will ignore modifiers.
            bindel = [
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"
            ];
            bindl = [
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              ", XF86AudioPlay, exec, playerctl play-pause"
              ", XF86AudioPrev, exec, playerctl previous"
              ", XF86AudioNext, exec, playerctl next"
            ];
            binde = [
              # Vim Style Window Resize
              "$mod ALT, H, resizeactive, -10 0"
              "$mod ALT, L, resizeactive, 10 0"
              "$mod ALT, K, resizeactive, 0 -10"
              "$mod ALT, J, resizeactive, 0 10"
            ];
            bindm = [
              "SHIFT, $LMB, movewindow"
              "ALT, $LMB, resizewindow"
            ];
            bind = [
              # "$mod, TAB, overview:toggle"
              # "$mod, Tab, hyprexpo:expo, toggle"
              "$mod, p, exec, $colourPicker"

              "$mod, escape, exec, uwsm app -- wlogout"
              "$mod, l, exec, $lockscreen"

              # Clipboard
              "$mod, i, exec, $screenshotRegion"
              "$mod SHIFT, I, exec, $screenshot"
              ", PRINT, exec, $screenshot"
              "$mod, V, exec, $paste"
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

              # "$mod, 1, workspace, 1"
              # "$mod, 2, workspace, 2"
              # "$mod, 3, workspace, 3"
              # "$mod, 4, workspace, 4"
              # "$mod, 5, workspace, 5"
              # "$mod, 6, workspace, 6"
              # "$mod, 7, workspace, 7"
              # "$mod, 8, workspace, 8"
              # "$mod, 9, workspace, 9"
              # "$mod, 10, workspace, 0"

              # "$mod SHIFT, 1, movetoworkspace, 1"
              # "$mod SHIFT, 2, movetoworkspace, 2"
              # "$mod SHIFT, 3, movetoworkspace, 3"
              # "$mod SHIFT, 4, movetoworkspace, 4"
              # "$mod SHIFT, 5, movetoworkspace, 5"
              # "$mod SHIFT, 6, movetoworkspace, 6"
              # "$mod SHIFT, 7, movetoworkspace, 7"
              # "$mod SHIFT, 8, movetoworkspace, 8"
              # "$mod SHIFT, 9, movetoworkspace, 9"
              # "$mod SHIFT, 0, movetoworkspace, 0"

              "$mod, W, togglespecialworkspace, magic"
            ];
          }
          // import
          ./mocha.nix
          {};
      };
    });
}
