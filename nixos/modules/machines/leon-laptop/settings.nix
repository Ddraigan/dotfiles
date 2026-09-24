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
        ./_settings/system.nix
      ]
      ++ (with config.nixos; [
        locale
        fonts
        hyprland
        hyprlock
      ]);
  };
}
