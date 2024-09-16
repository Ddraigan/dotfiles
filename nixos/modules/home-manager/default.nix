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
  # hyprland = import ./hyprland;
  # rofi = import ./rofi;
  # tmux = import ./tmux;
  # wezterm = import ./wezterm;
  # starship = import ./starship;
  # zsh = import ./zsh;
  # waybar = import ./hyprland/waybar.nix;
  # neovim = import ./nvim.nix;
  # zoxide = import ./zoxide.nix;
  # hyprpaper = import ./hyprland/hyprpaper.nix;
}
