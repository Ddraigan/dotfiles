{...}: {
  nixos.greetd = {
    lib,
    pkgs,
    config,
    fonts,
    ...
  }: let
    hyprGreetConf =
      pkgs.writeText "hypr-greet.lua"
      #lua
      ''
        -- Greetd greeter: run regreet, then end the Hyprland session once the user is logged in.
        hl.on("hyprland.start", function()
          hl.exec_cmd("${lib.getExe config.programs.regreet.package}; hyprctl dispatch 'hl.dsp.exit()'")
        end)

        hl.config({
          misc = {
            disable_hyprland_logo = true,
            disable_splash_rendering = true,
            disable_hyprland_guiutils_check = true,
          },
          input = {
            kb_layout = "us",
            kb_variant = "${config.modules.nix.greetd.keyboardVariant}",
          },
        })
      '';
  in {
    options.modules.nix.greetd.keyboardVariant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Keyboard variant for the greeter session.";
    };

    config = {
      services.greetd = {
        enable = true;
        restart = false;
        settings = {
          default_session = {
            # command = "${config.programs.hyprland.package}/bin/hyprland --config ${hyprGreetConf}";
            command = "${lib.getExe config.programs.hyprland.package} --config ${hyprGreetConf}";
            user = "greeter";
          };
        };
      };

      environment.etc."greetd/skyline.jpg".source = ../../skyline.jpg;

      services.displayManager.regreet = {
        enable = true;
        settings = {
          env = {
            XDG_CURRENT_DESKTOP = "Hyprland";
            XDG_SESSION_TYPE = "wayland";
            XDG_SESSION_DESKTOP = "Hyprland";
          };
          background = {
            path = "/etc/greetd/skyline.jpg";
            fit = "Contain";
          };
          GTK = {
            application_prefer_dark_theme = true;
          };
        };
        theme = {
          package = pkgs.catppuccin-gtk;
          name = "Catppuccin-Mocha-Standard-Lavender-Dark";
        };
        font = {
          package = fonts.mono.package;
          name = fonts.mono.name_short;
        };
        iconTheme = {
          package = fonts.icons.package;
          name = fonts.icons.name;
        };
      };
    };
  };
}
