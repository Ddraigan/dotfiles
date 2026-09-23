{
  config,
  lib,
  ...
}: {
  nixos.base = lib.mkMerge (with config.nixos; [
    locale
    nix-settings
    nixpkgs
    leon
  ]);

  homeManager.base = lib.mkMerge (with config.homeManager; [
    nixpkgs
    git
    leon
    ({...}: {
      programs.home-manager.enable = true;
      global.home.fonts = {
        mono = {
          name = "Hack Nerd Font, Hack NF";
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
          enable = true;
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders.override {
            flavor = "mocha";
            accent = "mauve";
          };
          size = "32x32";
        };
      };
    })
  ]);
}
