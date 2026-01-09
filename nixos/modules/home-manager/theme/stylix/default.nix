{
  lib,
  config,
  pkgs,
  inputs,
  colours,
  ...
}: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];
  options.modules.theme.stylix.enable = lib.mkEnableOption "enable stylix";

  config = lib.mkIf config.modules.theme.stylix.enable {
    stylix = let
      font = config.global.home.fonts;
    in {
      enable = true;
      autoEnable = true;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };
      fonts = {
        monospace = font.mono;
        sansSerif = font.sans;
        serif = font.serif;
      };
      icons = {
        enable = true;
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "mocha";
          accent = "mauve";
        };
        light = "Papirus-Dark";
        dark = "Papirus-Dark";
      };
      base16Scheme = {
        base00 = colours.stripped.base;
        base01 = colours.stripped.mantle;
        base02 = colours.stripped.surface0;
        base03 = colours.stripped.surface1;
        base04 = colours.stripped.surface2;
        base05 = colours.stripped.text;
        base06 = colours.stripped.rosewater;
        base07 = colours.stripped.lavender;
        base08 = colours.stripped.red;
        base09 = colours.stripped.peach;
        base0A = colours.stripped.yellow;
        base0B = colours.stripped.green;
        base0C = colours.stripped.teal;
        base0D = colours.stripped.blue;
        base0E = colours.stripped.mauve;
        base0F = colours.stripped.flamingo;
      };
      targets = {
        dunst.enable = false;
        hyprland = {
          enable = false;
        };
        hyprlock.enable = false;
        rofi.enable = true;
        starship.enable = false;
        spicetify.enable = false;
        waybar.enable = false;
        tmux.enable = false;
        zen-browser = {
          enable = false;
          profileNames = ["default"];
        };
        wezterm.enable = false;
        gtk = {
          enable = true;
          extraCss = ''
            @define-color window_bg_color rgba(0, 0, 0, 0.0);
            @define-color view_bg_color rgba(0, 0, 0, 0.0);
            @define-color headerbar_bg_color rgba(0, 0, 0, 0.0);
            @define-color sidebar_bg_color rgba(0, 0, 0, 0.0);
            @define-color secondary_sidebar_bg_color rgba(0, 0, 0, 0.0);
          '';
        };
      };
    };
  };
}
