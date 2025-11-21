{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hypr
    ./waybar
    ./rofi
    ./walker
    ./dunst
    ./ashell
    ./spotify
    ./wlogout
    ./nemo
    ./zen
  ];
}
