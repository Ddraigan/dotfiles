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
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      settings = {
        enable_wayland = true;
        color_scheme = "Catppuccin Mocha";
        colors = {
          background = "transparent";
        };
        enable_tab_bar = false;
        automatically_reload_config = true;
        window_background_opacity = 0;
        window_background_image_hsb = {
          hue = 1.0;
          saturation = 1.0;
          brightness = 0.25;
        };
        use_dead_keys = false;
        font = lib.generators.mkLuaInline ''wezterm.font("Hack Nerd Font")'';
      };
    };
    # home.file = {
    #   ".config/wezterm" = {
    #   source = ../../../../../wezterm;
    # };
    # };
  };
}
