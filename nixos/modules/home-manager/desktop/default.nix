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
    ./caelestia
    ./walker
    ./dunst
    ./mpv
    ./ashell
    ./spotify
    ./wlogout
    ./nemo
    ./zen
  ];
}
