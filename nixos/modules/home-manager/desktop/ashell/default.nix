{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}: {
  options.modules.desktop.ashell = {
    enable = lib.mkEnableOption "Enable Ashell";
  };
  config = {
    programs.ashell = {
      enable = true;
      package = pkgs.unstable.ashell;
      settings = {
        log_level = "info";
        position = "Top";
        app_launcher_cmd = "waybar"; # example
        modules = {
          left = ["Workspaces" "SystemInfo"];
          right = ["Clock" "Tray"];
        };
      };
    };
  };
}
