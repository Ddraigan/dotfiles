{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # quickshell = {
    #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
    # catppuccin.url = "github:catppuccin/nix";
    # nixai.url = "github:olafkfreund/nix-ai-help";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };
    hyprqt6engine = {
      url = "github:hyprwm/hyprqt6engine";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      leon-laptop =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs;};
          modules = [
            ./machines/leon-laptop/configuration.nix
          ];
        };
      leon-pc =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {inherit inputs;};
          modules = [
            ./machines/leon-pc/configuration.nix
            ./modules/shared
            ./modules/nixos
            # inputs.catppuccin.nixosModules.catppuccin
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
          ./home-manager/leon/home.nix
          ./modules/shared
          ./modules/home-manager
          inputs.stylix.homeModules.stylix
          inputs.zen-browser.homeModules.beta
          inputs.spicetify-nix.homeManagerModules.spicetify
        ];
      };
      keane = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./home-manager/keane/home.nix
          ./modules/shared
          ./modules/home-manager
          inputs.stylix.homeModules.stylix
          inputs.zen-browser.homeModules.beta
          inputs.spicetify-nix.homeManagerModules.spicetify
          # inputs.dankMaterialShell.homeModules.dankMaterialShell.default
        ];
      };
    };
  };
}
