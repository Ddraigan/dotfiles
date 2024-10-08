{ pkgs, lib, config, ... }:

{
  options.modules.desktop.rofi.enable = lib.mkEnableOption "Enable Rofi";
  config = lib.mkIf config.modules.desktop.rofi.enable {
    programs.rofi =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        enable = true;
        cycle = true;
        # Install the wayland variant of rofi
        package = pkgs.rofi-wayland;
        # Set terminal to wezterm
        terminal = "${pkgs.wezterm}/bin/wezterm";
      };
  };
}
