{
  inputs,
  config,
  ...
}: {
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
        base
        shared
        fonts
        stylix
        nvim
        cmdline
      ]);
  };
}
