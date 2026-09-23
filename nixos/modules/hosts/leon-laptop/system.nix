{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
      [
        ./_host/configuration.nix
      ]
      ++ (with config.flake.modules.nixos; [
        locale
        hyprland
        hyprlock
      ]);
  };
}
