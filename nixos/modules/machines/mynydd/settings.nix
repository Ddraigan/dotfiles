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
        ./_settings/system.nix
      ]
      ++ (with config.nixos; [
        locale
        authentik
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
