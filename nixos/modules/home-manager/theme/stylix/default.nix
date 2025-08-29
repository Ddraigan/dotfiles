{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.theme.stylix.enable = lib.mkEnableOption "enable stylix";

  config = lib.mkIf config.modules.theme.stylix.enable {
    stylix = {
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
      icons = {
        enable = true;
        package = pkgs.candy-icons;
        light = "candy-icons";
        dark = "candy-icons";
      };
      base16Scheme = {
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
      };
      targets = {
        dunst.enable = true;
        hyprland = {
          enable = false;
        };
        hyprlock.enable = false;
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

            .panel {
                background-color: rgba(0, 0, 0, 0.0);  /* Transparent panel */
            }
          '';
        };
      };
    };
  };
}
