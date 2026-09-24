{
  config,
  lib,
  ...
}: {
  nixos.base = lib.mkMerge (with config.nixos; [
    locale
    nix-settings
    nixpkgs
  ]);

  homeManager.base = lib.mkMerge (with config.homeManager; [
    nixpkgs
    ({...}: {
      programs.home-manager.enable = true;
    })
  ]);
}
