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
    modules = [
      ./_host/home.nix
      config.flake.modules.homeManager.shared
      config.flake.modules.homeManager.fonts
      config.flake.modules.homeManager.stylix
      config.flake.modules.homeManager.nvim
      config.flake.modules.homeManager.cmdline
    ];
  };
}
