{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.rofi.enable = lib.mkEnableOption "Enable Rofi";
  config = lib.mkIf config.modules.desktop.rofi.enable {
    programs.rofi = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      enable = true;
      cycle = true;
      package = pkgs.rofi;
      terminal = "${pkgs.wezterm}/bin/wezterm";
      location = "center";
      modes = [
        "drun"
        "run"
        "window"
      ];
      extraConfig = {
        drun-display-format = "{icon} {name}";
        disable-history = false;
        hide-scrollbar = false;

        showIcons = true;

        sidebarMode = true;

        display-drun = " Apps";
        display-run = " Run";
        display-window = " Window";
        display-Network = " 󰤨 Network";
      };
    };
  };
}
