{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./nvim
    ./starship
    ./tmux
    ./wezterm
    ./zoxide
    ./eza
    ./zsh
    ./fastfetch
    ./terminal-core.nix
  ];
}
