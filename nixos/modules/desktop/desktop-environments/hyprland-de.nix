{
  config,
  lib,
  ...
}: {
  nixos.hyprland-de = lib.mkMerge (with config.nixos; [
    hyprland
    hyprlock
  ]);

  homeManager.hyrpland-de = lib.mkMerge (with config.homeManager; [
    uwsm
    hyprland
    hyprlock
    hypridle
    noctalia
    wlogout
  ]);
}
