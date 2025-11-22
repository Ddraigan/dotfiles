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
        initial_session = {
          # command = "${config.programs.hyprland.package}/bin/Hyprland --config ${hyprGreetConf}";
          command = "uswm start hyprland.desktop --config ${hyprGreetConf}";
          user = "greeter";
        };
        default_session = {
          command = "uwsm start default";
          user = "leon";
        };
      };
    };
    programs.regreet = {
      enable = true;
    };
  });
}
