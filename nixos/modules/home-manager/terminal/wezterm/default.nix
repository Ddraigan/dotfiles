{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.wezterm = {
    enable = lib.mkEnableOption "Enable Wezterm";
    primary-terminal = lib.mkEnableOption "Set as primary terminal global value";
  };
  config = lib.mkIf config.modules.terminal.wezterm.enable {
    home.packages = [
      pkgs.unstable.wezterm
    ];

    home.file = {
      ".config/wezterm" = {
        source = ../../../../../wezterm;
      };
    };
  };
}
