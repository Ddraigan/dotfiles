{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.mpv = {
    enable = lib.mkEnableOption "Enable MPV";
  };
  config = lib.mkIf config.modules.desktop.mpv.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
