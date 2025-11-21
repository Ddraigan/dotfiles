{
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = [
      pkgs.nerd-fonts.hack
    ];
    fonts.fontconfig.enable = true;
  };
}
