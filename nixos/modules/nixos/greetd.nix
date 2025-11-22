{
  lib,
  pkgs,
  config,
  ...
}: {
  options.modules.nix.greetd.enable = lib.mkEnableOption "Enable greetd";
  config = lib.mkIf config.modules.nix.greetd.enable (let
    hyprGreetConf = pkgs.writeText "hypr-greet.conf" ''
      exec-once = "${config.programs.regreet.package}/bin/regreet"; hyprctl dispatch exit
      misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          disable_hyprland_guiutils_check = true
      }
    '';
  in {
    services.greetd = {
      enable = true;
      vt = 1;
      restart = false;
      settings = {
        default_session = {
          command = "${config.programs.hyprland.package}/bin/hyprland --config ${hyprGreetConf}";
          user = "greeter";
        };
      };
    };
    environment.etc."greetd/skyline.jpg".source = ./skyline.jpg;
    programs.regreet = {
      enable = true;
      settings = {
        GTK = {
          application_prefer_dark_theme = true;
        };
        background = {
          path = "/etc/greetd/skyline.jpg";
          fit = "Contain";
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
