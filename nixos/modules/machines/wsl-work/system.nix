{
  inputs,
  config,
  ...
}: {
  flake-file.inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  flake.nixosConfigurations.wsl-work = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./_host/configuration.nix
    ];
  };

  flake.homeConfigurations.wsl-work = inputs.home-manager-unstable.lib.homeManagerConfiguration {
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
        leon
        base
        colours
        fonts
        stylix
        nvim
        cmdline
      ]);
  };
}
