{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  options.modules.desktop.zen.enable = lib.mkEnableOption "Enable Zen Browser";
  config = lib.mkIf config.modules.desktop.zen.enable {
    programs.zen-browser = {
      enable = true;
      nativeMessagingHosts = [pkgs.firefoxpwa];
      profiles."default" = {
        userChrome = '''';
        spaces = {
          "First" = {
            id = "bf0810f0-8216-458e-946b-d8e401616107";
            theme.opacity = 0.0;
            position = 1000;
          };
          "Second" = {
            id = "c0b6972d-e68f-4fd8-a60f-f3c0df9e4ca8";
            theme.opacity = 0.0;
            position = 2000;
          };
        };
      };
    };
  };
}
