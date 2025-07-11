{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      # url = "github:nix-community/home-manager";
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    walker.url = "github:abenz1267/walker";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      # Doesn't have this sadly
      # inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };
    # hyprpicker = {
    #   url = "github:hyprwm/hyprpicker";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    zen-browser,
    walker,
    hyprland,
    hyprlock,
    Hyprspace,
    hyprsplit,
    ...
  } @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      leon-laptop =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs;};
          modules = [./machines/leon-laptop/configuration.nix];
        };
      leon-pc =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs;};
          modules = [
            ./machines/leon-pc/configuration.nix
            ./modules/nixos
            # inputs.stylix.nixosModules.stylix
          ];
        };
    };

    homeConfigurations = {
      leon = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-manager/home.nix
          ./modules/home-manager
          # hyprland.homeManagerModules.default
          catppuccin.homeModules.catppuccin
          walker.homeManagerModules.walker
        ];
      };
    };
  };
}
