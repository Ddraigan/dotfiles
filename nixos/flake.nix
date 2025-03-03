{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    # ags.url = "github:Aylur/ags";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    walker.url = "github:abenz1267/walker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, zen-browser, walker, ... } @ inputs:
  {
    overlays = import ./overlays { inherit inputs; };
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      leon-laptop = nixpkgs.lib.nixosSystem
      {
        specialArgs = { inherit inputs; };
        modules = [ ./machines/leon-laptop/configuration.nix ];
      };
      leon-pc = nixpkgs.lib.nixosSystem
      {
        specialArgs = { inherit inputs; };
        modules = [ ./machines/leon-pc/configuration.nix ];
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
          walker.homeManagerModules.walker
        ];
      };
    };
  };
}
