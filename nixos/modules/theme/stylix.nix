{...}: {
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  homeManager.stylix =
    {
      lib,
      config,
      pkgs,
      inputs,
      colours,
      fonts,
      ...
    }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      config = let
        font = fonts;
        icons = font.icons;
      in
        with colours.stripped; {
          stylix = {
            enable = true;
            polarity = "dark";
            autoEnable = true;
            cursor = {
              package = pkgs.bibata-cursors;
              name = "Bibata-Modern-Ice";
              size = 24;
            };
            fonts = {
              monospace = {inherit (font.mono) name package;};
              sansSerif = {inherit (font.sans) name package;};
              serif = {inherit (font.serif) name package;};
            };
            icons = {
              enable = true;
              package = icons.package;
              light = icons.name;
              dark = icons.name;
            };
            base16Scheme = {
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
              tmux = {
                enable = false;
              };
              zen-browser = {
                enable = true;
                profileNames = ["default"];
              };
              firefox = {
                enable = true;
                profileNames = ["default"];
              };
              wezterm.enable = false;
              gtk = {
                enable = true;
                extraCss = with colours;
                #css
                  ''
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
    };
}