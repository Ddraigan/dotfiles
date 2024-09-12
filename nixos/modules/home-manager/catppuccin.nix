{ inputs, pkgs, ... }:
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "pink";
    pointerCursor = {
      enable = true;
      flavor = "mocha";
      accent = "sapphire";
    };
  };
}
