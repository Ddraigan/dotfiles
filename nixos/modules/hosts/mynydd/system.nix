{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.mynydd = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./_host/configuration.nix
      ./_host/hardware-configuration.nix
      config.flake.modules.nixos.containers
      config.flake.modules.nixos.quicksync
      config.flake.modules.nixos.traefik
      config.flake.modules.nixos.homeass
      config.flake.modules.nixos.cfddns
      config.flake.modules.nixos.portainer
      config.flake.modules.nixos.uptime-kuma
      config.flake.modules.nixos.jellyfin
      config.flake.modules.nixos.downloads
    ];
  };
}