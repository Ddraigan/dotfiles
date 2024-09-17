{ lib, config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./rofi
    ./terminal
    ./hyprland/waybar.nix
    ./hyprland/hyprpaper.nix
  ];
}
