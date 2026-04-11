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
    nix-test.url = "path:/home/leon/Downloads/test/test";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.3";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
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
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow"; # Make sure to change the tag to match your hyprland version
      inputs.hyprland.follows = "hyprland";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    diff-tool.url = "github:ddraigan/diff-tool";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    mkMachine = name: system: {stable ? true}: let
      pkgsSource =
        if stable
        then nixpkgs.lib
        else inputs.nixpkgs-unstable.lib;
    in
      pkgsSource.nixosSystem {
        system = system;
        specialArgs = {
          hostName = name;
          inherit inputs;
        };
        modules = [
          ./machines/${name}/configuration.nix
          ./modules/shared
          ./modules/nixos
        ];
      };

    mkIso = name: system:
      nixpkgs.lib.nixosSystem
      {
        system = system;
        specialArgs = {
          hostName = name;
          inherit inputs;
        };
        modules = [
          ./machines/${name}/configuration.nix
        ];
      };

    mkHome = name: system: {stable ? true}: let
      hmLib =
        if stable
        then inputs.home-manager.lib
        else inputs.home-manager-unstable.lib;
      pkgsSource =
        if stable
        then nixpkgs
        else inputs.nixpkgs-unstable;
    in
      hmLib.homeManagerConfiguration {
        pkgs = import pkgsSource {
          inherit system;
          config.allowUnfree = true;
        };

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
      leon-pc = mkMachine "leon-pc" "x86_64-linux" {stable = false;};
      leon-laptop = mkMachine "leon-laptop" "x86_64-linux";
      leon-dell = mkMachine "leon-dell" "x86_64-linux";
      mynydd = mkMachine "mynydd" "x86_64-linux";
      iso = mkIso "iso" "x86_64-linux";
    };

    homeConfigurations = {
      leon = mkHome "leon" "x86_64-linux" {stable = false;};
      leon-dell = mkHome "leon-dell" "x86_64-linux";
      keane = mkHome "keane" "x86_64-linux";
    };
  };
}
