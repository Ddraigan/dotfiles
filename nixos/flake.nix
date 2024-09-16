{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    # ags.url = "github:Aylur/ags";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... } @ inputs:
    {
      overlays = import ./overlays { inherit inputs; };
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem
          {
            specialArgs = { inherit inputs; };
            modules = [ ./nixos/configuration.nix ];
          };
      };

      homeConfigurations = {
        leon = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home-manager/home.nix
            ./modules/home-manager
            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };
}
