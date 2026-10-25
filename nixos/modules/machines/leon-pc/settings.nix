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
        ./_settings/system.nix
      ]
      ++ (with config.nixos; [
        leon
        cmdline
        base
        fonts
        hyprland
        umbriel
        noctalia-greeter
        nvidia
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
        ./_settings/home-leon.nix
      ]
      ++ (with config.homeManager; [
        leon
        cmdline
        base
        uwsm
        hyprland
        umbriel
        noctalia
        colours
        fonts
        stylix
        nvim
        wezterm
        gaming
        obs
        nemo
        spicetify
        nvidia
        zen
      ]);
  };
}
