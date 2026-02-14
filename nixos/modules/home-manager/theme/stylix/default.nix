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
    qt = {
      enable = false;
      platformTheme.name = "qtct";
      style.name = "adwaita-dark";
    };
    stylix = let
      font = config.global.home.fonts;
      icons = font.icons;
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
        package = icons.package;
        light = icons.name;
        dark = icons.name;
      };
      base16Scheme = with colours.stripped; {
        base00 = base;
        base01 = mantle;
        base02 = surface0;
        base03 = surface1;
        base04 = surface2;
        base05 = text;
        base06 = rosewater;
        base07 = lavender;
        base08 = red;
        base09 = peach;
        base0A = yellow;
        base0B = green;
        base0C = teal;
        base0D = blue;
        base0E = mauve;
        base0F = flamingo;
      };
      targets = {
        dunst.enable = false;
        hyprland = {
          enable = false;
        };
        noctalia-shell.enable = false;
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
        firefox.enable = false;
        wezterm.enable = false;
        gtk = {
          enable = true;
          extraCss = with colours; ''
            @define-color window_bg_color ${rgba rgb.crust 0.0};
            @define-color view_bg_color ${rgba rgb.crust 0.0};
            @define-color headerbar_bg_color ${rgba rgb.crust 0.0};
            @define-color sidebar_bg_color ${rgba rgb.crust 0.0};
            @define-color secondary_sidebar_bg_color ${rgba rgb.crust 0.0};
          '';
        };
      };
    };
  };
}
