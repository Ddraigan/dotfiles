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
        hyprland
        hyprlock
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
        base
        shared
        uwsm
        fonts
        stylix
        nvim
        cmdline
        wezterm
        noctalia
        hyprland
        hyprlock
        hypridle
        nemo
        spicetify
        wlogout
        zen
      ]);
  };
}
