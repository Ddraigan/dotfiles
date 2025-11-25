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
    ./terminal-core.nix
  ];
}
