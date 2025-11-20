{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.wezterm = {
    enable = lib.mkEnableOption "Enable Wezterm";
    primaryTerminal = lib.mkEnableOption "Set as primary terminal global value";
  };
  config = lib.mkIf config.modules.terminal.wezterm.enable {
    package = pkgs.unstable.wezterm;
    home.file = {
      ".config/wezterm" = {
        source = ../../../../../wezterm;
      };
    };
  };
}
