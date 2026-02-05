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
    ./noctalia
    ./dms
    ./zen
    ./obs
  ];
}
