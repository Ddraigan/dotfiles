{...}: {
  flake-file.inputs.nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";

  flake.modules.homeManager.shared =
    {
      config,
      lib,
      pkgs,
      inputs,
      ...
    }: {
      imports = [
        ../_shared
      ];
    };
}