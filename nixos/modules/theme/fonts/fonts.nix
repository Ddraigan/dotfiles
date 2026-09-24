{...}: let
  fontSet = {pkgs, ...}: {
    mono = {
      name = "Hack Nerd Font, Hack NF";
      name_short = "Hack Nerd Font";
      package = pkgs.nerd-fonts.hack;
    };
    sans = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
    serif = {
      name = "DejaVu Serif";
      package = pkgs.dejavu_fonts;
    };
    icons = {
      name = "Papirus-Dark";
      size = "32x32";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };
in {
  nixos.fonts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      fonts = fontSet {inherit pkgs;};
    in {
      config = {
        _module.args.fonts = fonts;
        fonts.packages = builtins.map (x: x.package) [
          fonts.mono
          fonts.sans
          fonts.serif
        ];
        fonts.fontDir.enable = true;
      };
    };

  homeManager.fonts =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      fonts = fontSet {inherit pkgs;};
    in {
      config = {
        _module.args.fonts = fonts;
        home.packages = builtins.map (x: x.package) [
          fonts.mono
          fonts.sans
          fonts.serif
        ];
        fonts.fontconfig.enable = true;
      };
    };
}
