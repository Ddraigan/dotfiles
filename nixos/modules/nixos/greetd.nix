{
  lib,
  pkgs,
  config,
  hostName,
  ...
}: {
  options.modules.nix.greetd.enable = lib.mkEnableOption "Enable greetd";
  config = lib.mkIf config.modules.nix.greetd.enable (let
    kbVariant =
      if hostName == "leon-pc"
      then ""
      else "dvorak";

    # exec-once = "${config.programs.regreet.package}/bin/regreet"; hyprctl dispatch exit
    hyprGreetConf = pkgs.writeText "hypr-greet.conf" ''
      exec-once = ${lib.getExe config.programs.regreet.package}; hyprctl dispatch exit

      misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          disable_hyprland_guiutils_check = true
      }
      input {
          kb_layout = us
          ${lib.optionalString (kbVariant != "") "kb_variant = ${kbVariant}"}
      }
    '';
  in {
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
    environment.etc."greetd/skyline.jpg".source = ./skyline.jpg;
    programs.regreet = {
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
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
      # extraCss = ''
      # '';
    };
  });
}
