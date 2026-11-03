{...}: {
  flake-file.inputs.amethyst.url = "github:ChrisDKN/Amethyst-Mod-Manager/main";

  nixos.amethyst = {
    pkgs,
    lib,
    config,
    inputs,
    ...
  }: {
    environment.systemPackages = [
      pkgs.p7zip
      pkgs.unzip
      inputs.amethyst.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
