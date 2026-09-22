{
  inputs,
  config,
  ...
}: {
  flake-file.inputs.nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

  flake.nixosConfigurations.wsl-work = inputs.nixpkgs-unstable.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ./_host/configuration.nix
    ];
  };
}