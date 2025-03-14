{ config, lib, pkgs, ... }:

{
  options.modules.desktop.hypr.hypridle = {
    enable = lib.mkEnableOption "Enable HyprIdle";
  };

  config = lib.mkIf config.modules.desktop.hypr.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 600;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
