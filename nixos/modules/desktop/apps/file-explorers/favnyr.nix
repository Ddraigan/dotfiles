{...}: {
  flake-file.inputs = {
    favnyr.url = "github:GlitchAwakened/Favnyr?dir=packaging/nix";
  };

  nixos.favnyr = {
    pkgs,
    inputs,
    ...
  }: {
    environment.systemPackages = [
      inputs.favnyr.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.mime.defaultApplications = {
      "inode/directory" = "favnyr.desktop";
    };
  };
}
