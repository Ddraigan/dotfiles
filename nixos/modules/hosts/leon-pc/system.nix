{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.leon-pc = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules =
      [
        ./_host/configuration.nix
      ]
      ++ (with config.nixos; [
        cmdline
        base
        greetd
        nvidia
        hyprland
        hyprlock
        gaming
        sunshine
      ]);
  };
}
