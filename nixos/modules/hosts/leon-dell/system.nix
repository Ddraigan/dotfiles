{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-dell = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
      [
        ./_host/configuration.nix
      ]
      ++ (with config.flake.modules.nixos; [
        greetd
        hyprland
        sunshine
      ]);
  };
}
