{ pkgs, lib, config, ... }:

{
  options.modules.terminal.wezterm.enable = lib.mkEnableOption "Enable Wezterm";
  config = lib.mkIf config.modules.terminal.wezterm.enable {
    home.packages = [
      pkgs.wezterm
    ];

    home.file = {
      ".config/wezterm" = {
        source = ../../../../../wezterm;
      };
    };
  };
}
