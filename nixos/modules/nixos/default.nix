{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop
    ./nvidia.nix
    ./greetd.nix
    ./secureboot.nix
    ./sunshine.nix
  ];
}
