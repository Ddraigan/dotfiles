{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.modules.desktop.caelestia = {
    enable = lib.mkEnableOption "Enable Caelestia";
  };
  config = lib.mkIf config.modules.desktop.caelestia.enable {
    programs.caelestia = {
      enable = true;
      systemd = {
        enable = false; # if you prefer starting from your compositor
        target = "graphical-session.target";
        environment = [];
      };
      settings = {
        bar.status = {
          showBattery = false;
        };
        paths.wallpaperDir = "../hypr/hyprpaper/";
      };
      cli = {
        enable = true; # Also add caelestia-cli to path
        settings = {
          theme.enableGtk = false;
        };
      };
    };
  };
}
