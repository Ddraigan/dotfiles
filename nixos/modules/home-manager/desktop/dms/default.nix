{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
  ];
  options.modules.desktop.dms = {
    enable = lib.mkEnableOption "Enable Dank Material Shell";
  };
  config = lib.mkIf config.modules.desktop.dms.enable {
    programs.dankMaterialShell = {
      enable = true;
      # quickshell.package = pkgs.quickshell;
      systemd = {
        enable = false; # Systemd service for auto-start
        restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
      };
      # Core features
      enableSystemMonitoring = true; # System monitoring widgets (dgop)
      enableClipboard = false; # Clipboard history manager
      enableVPN = true; # VPN management widget
      # enableBrightnessControl = false; # Backlight/brightness controls
      # enableColorPicker = false; # Color picker tool
      enableDynamicTheming = false; # Wallpaper-based theming (matugen)
      enableAudioWavelength = true; # Audio visualizer (cava)
      enableCalendarEvents = true; # Calendar integration (khal)
      enableSystemSound = true; # System sound effects
    };
    # plugins = {
    #   myPlugin = {
    #     enable = true;
    #     src = ./path/to/plugin;
    #   };
    # };
  };
}
