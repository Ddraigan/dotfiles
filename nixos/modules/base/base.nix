{
  config,
  lib,
  ...
}: {
  nixos.base = lib.mkMerge (with config.nixos; [
    locale
    nix-settings
    nixpkgs
    leon
  ]);

  homeManager.base = lib.mkMerge (with config.homeManager; [
    nixpkgs
    git
    leon
    ({...}: {
      programs.home-manager.enable = true;
    })
  ]);
}
