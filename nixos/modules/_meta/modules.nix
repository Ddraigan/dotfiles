{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.home-manager-unstable.flakeModules.default
  ];

  options.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.deferredModule);
    default = {};
    description = "NixOS features.";
  };

  options.homeManager = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.deferredModule);
    default = {};
    description = "Home-manager features.";
  };
}
