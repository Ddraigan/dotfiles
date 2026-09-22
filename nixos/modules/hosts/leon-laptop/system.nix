{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./_host/configuration.nix
      ./_host/hardware-configuration.nix
      config.flake.modules.nixos.hyprland
    ];
  };
}