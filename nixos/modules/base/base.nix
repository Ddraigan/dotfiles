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

  homeManager.base = {};
}
