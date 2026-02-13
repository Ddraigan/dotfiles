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
      workspaces = lib.range 1 9;
      wsBinds =
        lib.concatMap (i: [
          "$mod, ${toString i}, split:workspace, ${toString i}"
          "$mod SHIFT, ${toString i}, split:movetoworkspace, ${toString i}"
        ])
        workspaces;
    in {
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
        # package = null;
        package = inputs.hyprland.packages.${sys}.hyprland;
        portalPackage = null;
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
          # inputs.hypr-darkwindow.packages.${sys}.Hypr-DarkWindow
        ];
        settings = {
          "plugin:hyprsplit" = {
            num_workspaces = 9;
            bind =
              wsBinds
              ++ [
                "$mod SHIFT, n, split:swapactiveworkspaces, current +1"
                "$mod SHIFT, W, split:movetoworkspace, special:magic"
              ];
          };
          # "plugin:darkwindow:load_shaders" = "chromakey";
          # "plugin:darkwindow" = {
          #   windowrule = [
          #     "darkwindow:shade chromakey bkg=[0.0 0.0 0.0] targetOpacity=0.0, match:class spotify"
          #     "darkwindow:shade chromakey bkg=[0.255 0.255 0.255] targetOpacity=0.0, match:class com.github.wwmm.easyeffects"
          #   ];
          # };

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
          "$lockScreen" = "${uwsmUtils.wrap "hyprlock"}";
          "$sessionScreen" = "${uwsmUtils.wrap "wlogout"}";
          "$screenshot" = "${uwsmUtils.wrap "hyprshot -m window"}";
          "$screenshotRegion" = "${uwsmUtils.wrap "hyprshot -m region output --clipboard-only"}";

          # env =
          # [
          # "XDG_SCREENSHOTS_DIR,$HOME/Pictures/screenshots"
          # "XDG_PICTURES_DIR,$HOME/Pictures"
          # "HYPRSHOT_DIR,$HOME/Pictures/screenshots"
          # ];
          # ++ lib.optionals (lib.elem hyprQTPkg config.home.packages) [
          #   # When using hyprqt6engine over qt6ct
          #   "QT_QPA_PLATFORMTHEME=hyprqt6engine"

          exec-once = [
            "systemctl --user enable --now hyprpolkitagent.service"
            "systemctl --user enable --now hypridle.service"
            "systemctl --user enable --now hyprpaper.service"
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
            rounding = 12;
            active_opacity = 1.0;
            inactive_opacity = 0.9;
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

            follow_mouse = 1;
            sensitivity = 0;
          };

          "$mod" = cfg.mod;
          "$LMB" = "mouse:272";
          "$RMB" = "mouse:273";

          bindel = [
            # ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%+"
            # ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 1%-"

            # Keyboard backlight
            ", XF86KbdBrightnessUp, exec, brightnessctl -d *kbd* set +5%"
            ", XF86KbdBrightnessDown, exec, brightnessctl -d *kbd* set 5%-"
          ];
          bindl = [
            # ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            # ", XF86AudioPlay, exec, playerctl play-pause"
            # ", XF86AudioPrev, exec, playerctl previous"
            # ", XF86AudioNext, exec, playerctl next"
          ];
          binde = [
            ##! Vim Style Window Resize
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

            "$mod, escape, exec, $sessionScreen"
            # "$mod, l, exec, $locksCreen"

            ##! Clipboard
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

            # Touchpad
            ", XF86TouchpadToggle, exec, hyprctl keyword device:*:enabled toggle"
            ", XF86TouchpadOn, exec, hyprctl keyword device:*:enabled true"
            ", XF86TouchpadOff, exec, hyprctl keyword device:*:enabled false"
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

