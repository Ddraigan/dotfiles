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
    ./spotify
    ./wlogout
    ./nemo
    ./zen
  ];
}
