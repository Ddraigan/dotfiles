{...}: {
  flake-file.inputs = {
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
  };

  nixos.umbriel = {
    lib,
    pkgs,
    config,
    inputs,
    ...
  }: {
    imports = [inputs.umbriel.nixosModules.default];
    nix.settings = {
      extra-substituters = ["https://umbriel.cachix.org"];
      extra-trusted-public-keys = [
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };
    programs = {
      umbriel.enable = true;
    };
  };

  homeManager.umbriel = {
    lib,
    pkgs,
    config,
    inputs,
    ...
  }: {
    imports = [inputs.umbriel.homeModules.default];
    programs = {
      umbriel = {
        enable = true;
        settings = {
          general = {
            autostart = ["noctalia" "wezterm"];
            border_size = 1;
            gaps = 5;
            mod_key = "Super";
            xwayland = true;
          };
          output = {
            "DP-1" = {
              mode = "preferred";
              position = "0,0";
              scale = 1;
              bitdepth = 10;
              hdr = "on";
              sdr_white = 203;
              sdr_min_luminance = 0.005;
            };
            "DP-2" = {
              mode = "preferred";
              position = "auto-left";
              scale = "auto";
              bitdepth = 8;
              hdr = "off";
            };
          };
          keybinds = let
            wsBinds = builtins.listToAttrs (
              map (
                number: let
                  key =
                    if number == 10
                    then "0"
                    else toString number;
                in {
                  name = "Mod+${key}";
                  value = "workspace-switch:${toString number}";
                }
              ) (builtins.genList (index: index + 1) 10)
              ++ map (
                number: let
                  key =
                    if number == 10
                    then "0"
                    else toString number;
                in {
                  name = "Mod+Shift+${key}";
                  value = "window-move-to-workspace:${toString number}";
                }
              ) (builtins.genList (index: index + 1) 10)
            );
          in
            lib.mkMerge [
              wsBinds
              {
                # Apps & Tools
                "Mod+B" = "spawn:zen-beta";
                "Mod+T" = "spawn:wezterm";
                "Mod+F" = "spawn:nemo";
                "Mod+P" = "spawn:hyprpicker -a";
                "Mod+Escape" = "spawn:noctalia msg panel-toggle session";

                # Screenshots
                "Mod+I" = "spawn:hyprshot -m region output --clipboard-only";
                "Mod+Shift+I" = "spawn:hyprshot -m window";
                "Print" = "spawn:hyprshot -m window";

                # Window Management
                "Mod+Shift+Q" = "window-close";
                "Mod+Shift+F" = "window-fullscreen";
                "Mod+Shift+Z" = "window-toggle-float";
                "Mod+Shift+X" = "session-quit";

                # Focus Directionals (Arrows + Vim keys)
                "Mod+Left" = "focus-monitor-or-window-left";
                "Mod+Right" = "focus-monitor-or-window-right";
                "Mod+Up" = "focus-monitor-or-window-up";
                "Mod+Down" = "focus-monitor-or-window-down";
                "Mod+H" = "focus-monitor-or-window-left";
                "Mod+L" = "focus-monitor-or-window-right";
                "Mod+K" = "focus-monitor-or-window-up";
                "Mod+J" = "focus-monitor-or-window-down";

                # Moving Windows
                "Mod+Shift+H" = "window-move-left";
                "Mod+Shift+L" = "window-move-right";
                "Mod+Shift+K" = "window-move-up";
                "Mod+Shift+J" = "window-move-down";
              }
            ];
        };
      };
    };
  };
}
