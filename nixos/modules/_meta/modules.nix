{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager-unstable.flakeModules.default
  ];

  flake.modules = {};
}
