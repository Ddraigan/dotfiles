{ lib, config, pkgs, ... }:

{
  imports = [
    ./nvim
    ./starship
    ./tmux
    ./wezterm
    ./zoxide
    ./zsh
  ];
}
