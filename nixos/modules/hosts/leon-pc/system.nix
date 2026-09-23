{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-pc = inputs.nixpkgs-unstable.lib.nixosSystem {
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
        nvidia
        hyprland
        hyprlock
        gaming
        sunshine
      ]);
  };

  flake.homeConfigurations.leon = inputs.home-manager-unstable.lib.homeManagerConfiguration {
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
        wezterm
        cmdline
        noctalia
        gaming
        obs
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
