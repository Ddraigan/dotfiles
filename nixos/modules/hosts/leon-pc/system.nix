{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-pc = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./_host/configuration.nix
      ./_host/hardware-configuration.nix
      config.flake.modules.nixos.greetd
      config.flake.modules.nixos.nvidia
      config.flake.modules.nixos.hyprland
      config.flake.modules.nixos.gaming
      config.flake.modules.nixos.sunshine
    ];
  };
}