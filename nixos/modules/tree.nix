{
  inputs,
  lib,
  ...
}: {
  systems = ["x86_64-linux"];

  imports = [
    ./_meta/modules.nix
    ./_meta/overlays.nix
    ./_meta/flake-file.nix
  ];
}