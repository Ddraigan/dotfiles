{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./traefik
    ./homeass
  ];
}
