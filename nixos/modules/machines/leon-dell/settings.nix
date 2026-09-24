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
        ./_settings/system.nix
      ]
      ++ (with config.nixos; [
        leon
        cmdline
        base
        fonts
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
        ./_settings/home-leon.nix
      ]
      ++ (with config.homeManager; [
        leon
        cmdline
        base
        hyprland-de
        colours
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
