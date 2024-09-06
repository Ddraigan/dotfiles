# flake.nix

{
  description = "Nixos config flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      #overlays = import ./modules/overlays { inherit inputs; };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs outputs; };
            modules = [ ./nixos/configuration.nix ];
          };
      };
    };
}
