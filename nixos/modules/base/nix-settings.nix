{...}: {
  nixos.nix-settings = {
    lib,
    config,
    inputs,
    ...
  }: {
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      settings = {
        experimental-features = ["nix-command" "flakes"];
        nix-path = config.nix.nixPath;
      };
    };
  };
}
