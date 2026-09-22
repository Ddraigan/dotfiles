{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.flake-file.flakeModules.default
  ];

  flake-file = {
    description = "Nixos config flake";
    outputs = "dendritic";
    inputs = {
      flake-file.url = lib.mkDefault "github:denful/flake-file";
      flake-parts.url = "github:hercules-ci/flake-parts";
      import-tree.url = "github:denful/import-tree";
      nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager/release-26.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager-unstable = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
      diff-tool.url = "github:ddraigan/diff-tool";
      dgop = {
        url = "github:AvengeMedia/dgop";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
      };
    };
  };
}