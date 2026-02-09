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
      icons = font.icons;
      stripped = colours.stripped;
      rgb = colours.rgb;
      rgba = colours.rgba;
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
      base16Scheme = {
        base00 = stripped.base;
        base01 = stripped.mantle;
        base02 = stripped.surface0;
        base03 = stripped.surface1;
        base04 = stripped.surface2;
        base05 = stripped.text;
        base06 = stripped.rosewater;
        base07 = stripped.lavender;
        base08 = stripped.red;
        base09 = stripped.peach;
        base0A = stripped.yellow;
        base0B = stripped.green;
        base0C = stripped.teal;
        base0D = stripped.blue;
        base0E = stripped.mauve;
        base0F = stripped.flamingo;
      };
      targets = {
        dunst.enable = false;
        hyprland = {
          enable = false;
        };
        # noctalia-shell.enable = false;
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
