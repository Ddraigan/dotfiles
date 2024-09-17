{ lib, config, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./rofi
    ./tmux
    ./wezterm
    ./starship
    ./zsh
    ./hyprland/waybar.nix
    ./nvim.nix
    ./zoxide.nix
    ./hyprland/hyprpaper.nix
  ];
}
