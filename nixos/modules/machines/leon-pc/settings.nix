{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-pc = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = with config.nixos; [
      leon-pc
      leon
      cmdline
      base
      fonts
      hyprland-de
      greetd
      nvidia
      gaming
      sunshine
    ];
  };

  flake.homeConfigurations.leon = inputs.home-manager-unstable.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = with config.homeManager; [
      leon-pc-home-leon
      leon
      cmdline
      base
      hyprland-de
      colours
      fonts
      stylix
      nvim
      wezterm
      gaming
      obs
      nemo
      spicetify
      zen
    ];
  };
}
