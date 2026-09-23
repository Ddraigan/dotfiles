{
  config,
  lib,
  ...
}: {
  nixos.cmdline = lib.mkMergea (with config.nixos; [
    zsh
  ]);

  homeManager.cmdline = lib.mkMerge (with config.homeManager; [
    zsh
    tmux
    zoxide
    fastfetch
    starship
    eza
  ]);
}
