{config, lib, ...}: {
  nixos.cmdline = lib.mkMerge [
    config.nixos.zsh
  ];

  homeManager.cmdline = lib.mkMerge [
    config.homeManager.zsh
    config.homeManager.tmux
    config.homeManager.zoxide
    config.homeManager.fastfetch
    config.homeManager.starship
    config.homeManager.eza
  ];
}