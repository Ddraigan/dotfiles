{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.theme.stylix.enable = lib.mkEnableOption "enable stylix";

  config = lib.mkIf config.modules.theme.stylix.enable {
    stylix = let
      col = config.theme.colours.catppuccin.mocha;
    in  {
      enable = true;
      autoEnable = true;
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 20;
      };
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.hack;
          name = "Hack Nerd Font";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
      };
      # opacity = {
      #   applications = 0.2;
      #   popups = 0.2;
      #   desktop = 0.2;
      # };
      # icons = {
      #   enable = true;
      #   package = pkgs.candy-icons;
      #   light = "candy-icons";
      #   dark = "candy-icons";
      # };
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
        # zen-browser = {
        #   enable = true;
        #   profileNames = ["default"];
        # };
        wezterm.enable = false;
        gtk = {
          enable = true;
          extraCss = ''
            * {
                background-color: rgba(0, 0, 0, 0.0);  /* Semi-transparent black background */
            }

            window {
                background-color: rgba(0, 0, 0, 0.0);  /* More transparent window background */
            }

            .button {
                background-color: rgba(242, 205, 205, 0.5); /* Transparent button background */
            }

            # .panel {
            #     background-color: rgba(0, 0, 0, 0.0);  /* Transparent panel */
            # }
          '';
        };
      };
    };
  };
}
