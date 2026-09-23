{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-dell = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
      [
        ./_host/configuration.nix
      ]
      ++ (with config.nixos; [
        cmdline
        base
        greetd
        sunshine
      ]);
  };

  flake.homeConfigurations.leon-dell = inputs.home-manager-unstable.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit inputs;
    };
    modules =
      [
        ./_host/home.nix
      ]
      ++ (with config.homeManager; [
        cmdline
        base
        hyprland-de
        shared
        fonts
        stylix
        nvim
        wezterm
        nemo
        spicetify
        zen
      ]);
  };
}
