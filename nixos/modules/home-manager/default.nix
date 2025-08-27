{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop
    ./terminal
  ];
}
