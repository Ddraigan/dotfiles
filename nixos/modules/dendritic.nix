{inputs, ...}: {
  flake-file.inputs = {
    #   nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # flake-parts = {
    #   url = "github:hercules-ci/flake-parts";
    #   inputs.nixpkgs-lib.follows = "nixpkgs";
    # };
    #   flake-file.url = lib.mkDefault "github:vic/flake-file";
    #   import-tree.url = "github:vic/import-tree";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    # inputs.flake-parts.flakeModules.modules
    # inputs.flake-file.flakeModules.default
    inputs.flake-file.flakeModules.dendritic
  ];

  # import all modules recursively with import-tree
  # flake-file.outputs = ''
  #   inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  # '';

  # set flake.systems
  # systems = [
  #   "aarch64-darwin"
  #   "aarch64-linux"
  #   "x86_64-darwin"
  #   "x86_64-linux"
  # ];
}
