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
    ./mpv
    ./ashell
    ./spotify
    ./wlogout
    ./lutris
    ./nemo
    ./dms
    ./zen
    ./obs
  ];
}
