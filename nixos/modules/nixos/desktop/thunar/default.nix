{ pkgs, lib, config, ... }:

{
  options.modules.desktop.thunar.enable = lib.mkEnableOption "Enable Thunar";
  config = lib.mkIf config.modules.desktop.thunar.enable { 
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
      xfconf.enable = true;
    };
    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images
    };
  };
}
