{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.mpv = {
    enable = lib.mkEnableOption "Install configure and enable Nemo file manager";
  };
  config = lib.mkIf config.modules.desktop.mpv.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
