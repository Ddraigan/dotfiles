{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-proton-cachyos.url = "github:kimjongbing/nix-proton-cachyos";
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
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow"; # Make sure to change the tag to match your hyprland version
      inputs.hyprland.follows = "hyprland";
    };
    diff-tool.url = "github:ddraigan/diff-tool";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkMachine = name: system:
      nixpkgs.lib.nixosSystem
      {
        system = system;
        specialArgs = {inherit inputs;};
        modules = [
          ./machines/${name}/configuration.nix
          ./modules/shared
          ./modules/nixos
        ];
      };

    mkHome = name: system:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};

        extraSpecialArgs = {
          profileName = name;
          inherit inputs;
        };

        modules = [
          ./home-manager/${name}/home.nix
          ./modules/shared
          ./modules/home-manager
        ];
      };
  in {
    overlays = import ./overlays {inherit inputs;};

    nixosConfigurations = {
      leon-pc = mkMachine "leon-pc" "x86_64-linux";
      leon-laptop = mkMachine "leon-laptop" "x86_64-linux";
      leon-dell = mkMachine "leon-dell" "x86_64-linux";
    };

    homeConfigurations = {
      leon = mkHome "leon" "x86_64-linux";
      leon-dell = mkHome "leon-dell" "x86_64-linux";
      keane = mkHome "keane" "x86_64-linux";
    };
  };
}
