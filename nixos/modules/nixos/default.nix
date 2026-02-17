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
    ./containers
    # ./secureboot.nix
    ./sunshine.nix
    ./solaar.nix
  ];
}
