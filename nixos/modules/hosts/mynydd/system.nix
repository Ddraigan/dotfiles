{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.mynydd = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
      [
        ./_host/configuration.nix
      ]
      ++ (with config.flake.modules.nixos; [
        containers
        quicksync
        traefik
        homeass
        cfddns
        portainer
        uptime-kuma
        jellyfin
        downloads
      ]);
  };
}
