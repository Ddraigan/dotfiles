{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.theme.stylix.enable = lib.mkEnableOption "enable stylix";

  config = lib.mkIf config.modules.theme.stylix.enable {
    stylix = let
      col = config.global.theme.colours.catppuccin.mocha;
      font = config.global.home.fonts;
    in {
      enable = true;
      autoEnable = true;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 60;
        # size = 20;
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
        base00 = col.base;
        base01 = col.mantle;
        base02 = col.surface0;
        base03 = col.surface1;
        base04 = col.surface2;
        base05 = col.text;
        base06 = col.rosewater;
        base07 = col.lavender;
        base08 = col.red;
        base09 = col.peach;
        base0A = col.yellow;
        base0B = col.green;
        base0C = col.teal;
        base0D = col.blue;
        base0E = col.mauve;
        base0F = col.flamingo;
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
