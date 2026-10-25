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
    colours,
    ...
  }: {
    imports = [inputs.umbriel.homeModules.default];
    programs = {
      umbriel = {
        enable = true;
        settings = {
          general = {
            autostart = ["noctalia" "wezterm"];
            mod_key = "Super";
            xwayland = true;
          };
          layout = {
            mode = "dwindle";
            gap = 5;
          };
          input = {
            focus = {
              follows_mouse = true;
            };
          };
          colors = {
            background = colours.hex.base;
            text_primary = colours.hex.text;
            text_muted = colours.hex.surface2;
            shadow = "${colours.hex.mantle}7F";
            border = {
              focused = "${colours.hex.pink}FF";
              unfocused = "${colours.hex.mantle}FF";
              outer = "${colours.hex.crust}FF";
            };
            overview = {
              background_tint = "${colours.hex.base}80";
              workspace_background = "${colours.hex.mantle}B3";
              badge = colours.hex.pink;
            };
            tab_bar = {
              background = colours.hex.mantle;
              text = colours.hex.surface2;
              active = colours.hex.pink;
            };
          };
          appearance = {
            prefer_no_csd = true;
            blur = {
              enabled = true;
              optimized = true;
              passes = 2;
              radius = 2;
              brightness = 0.7;
              contrast = 0.5;
              saturation = 1.0;
            };
          };
          window_rule = [
            {
              blur = true;
              blur_optimized = true;
            }
          ];
          layer_rule = [
            {
              blur = true;
              blur_ignore_alpha = 0.5;
              blur_optimized = true;
            }
            # {
            #   match.namespace = "^noctalia-bar-";
            #   blur = true;
            #   blur_ignore_alpha = 0.5;
            #   blur_popups = true;
            # }
          ];
          output = {
            "DP-1" = {
              position = [0 0];
              scale = 1.0;
              hdr = "on";
              bit_depth = 10;
              sdr_white = 203;
              focus_at_startup = true;
            };
            "DP-2" = {
              scale = 1.0;
              position = [(-1920) 0];
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
                "Mod+Shift+F" = "window-toggle-fullscreen";
                "Mod+Shift+Z" = "window-toggle-floating";
                "Mod+Shift+X" = "session-quit";
                "Mod+Shift+N" = "workspace-swap-active-output-next";

                # Focus Directionals
                "Mod+Left" = "window-focus-or-output-left";
                "Mod+Right" = "window-focus-or-output-right";
                "Mod+Up" = "window-focus-or-output-up";
                "Mod+Down" = "window-focus-or-output-down";
                "Mod+H" = "window-focus-or-output-left";
                "Mod+L" = "window-focus-or-output-right";
                "Mod+K" = "window-focus-or-output-up";
                "Mod+J" = "window-focus-or-output-down";

                # Moving Windows/Columns
                "Mod+Shift+H" = "column-move-left";
                "Mod+Shift+L" = "column-move-right";
                "Mod+Shift+K" = "window-move-up";
                "Mod+Shift+J" = "window-move-down";
              }
            ];
        };
      };
    };
  };
}
