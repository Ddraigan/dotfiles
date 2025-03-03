{ pkgs, inputs, lib, config, system, ... }:

{
  options.modules.desktop.hypr.hyprland.enable = lib.mkEnableOption "Enable Hyprland";

  config = lib.mkIf config.modules.desktop.hypr.hyprland.enable {
    home.packages = with pkgs; [
      # File Manager
      nautilus

      # Clipboard
      wl-clipboard

      # Notifications
      # dunst (has its own config)
      # libnotify (with dunst)

      # Screenshot Utils
      hyprshot
      grim
      slurp
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        # inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.plugin here
        inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      ];
      settings = {
        "plugin:hyprexpo" = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "center current"; # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true; # laptop touchpad
            gesture_fingers = 3;  # 3 or 4
            gesture_distance = 300; # how far is the "max"
            gesture_positive = true; # positive = swipe down. Negative = swipe up.
        };

        "$terminal" = "wezterm";
        "$fileManager" = "nautilus";
        # "$menu" = "rofi -show drun -show-icons";
        "$menu" = "walker";
        "$browser" = "zen";

        env = [
          "XDG_SCREENSHOTS_DIR,$HOME/Pictures/screenshots"
          "XDG_PICTURES_DIR,$HOME/Pictures"
          "HYPRSHOT_DIR,$HOME/Pictures/screenshots"
        ];

        exec-once = [
          "$terminal"
          # "$browser"
          # "hyprnotify"
          # "dunst"
          # "waybar"
          "nm-applet --indicator"
          "wl-paste -p --watch wl-copy"
        ];

        windowrulev2 = "suppressevent maximize, class:.*";

        general = {
          border_size = 2;
          gaps_in = 5;
          gaps_out = 20;
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";

          "col.inactive_border" = "$mantle";
          "col.active_border" = "$border";
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
          "DP-2, preferred, 0x0, 1"
          ", preferred, auto-left, auto"
        ];

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
          workspace_swipe = true;
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
            # Doesn't exist?
          # "XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
          # "XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ];
        binde = [
              # Doesn't exist?
          # "XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
        bindm = [
          "SHIFT, $LMB, movewindow"
          "ALT, $LMB, resizewindow"
        ];
        bind = [
          # Plugins
          # "$mod, TAB, overview:toggle"
          "$mod, Tab, hyprexpo:expo, toggle"

          "$mod, escape, exec, hyprlock"

          # Clipboard
          "$mod, i, exec, hyprshot -m region output --clipboard-only"
          "$mod SHIFT, I, exec, hyprshot -m window"
          ", PRINT, exec, hyprshot -m window"
          "$mod, V, exec, wl-paste"
          "$mod, C, exec, wl-copy"

          "$mod, D, exec, $menu"
          "$mod, B, exec, $browser"
          "$mod, T, exec, $terminal"
          "$mod, F, exec, $fileManager"

          "$mod SHIFT, X, exit"
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

          # Vim Window Resize
          "$mod ALT, H, resizeactive, -10 0"
          "$mod ALT, L, resizeactive, 10 0"
          "$mod ALT, K, resizeactive, 0 -10"
          "$mod ALT, J, resizeactive, 0 10"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 10, workspace, 0"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 0"

          "$mod, W, togglespecialworkspace, magic"
          "$mod SHIFT, W, movetoworkspace, special:magic"
        ];
      }

      // import
        ./mocha.nix
        { };
    };
  };
}
