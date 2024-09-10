{ pkgs, lib, config, ... }:

{
  config = {
    home.packages = [
      pkgs.hyprpaper
    ];
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "off";
        preload = [
          "~/dotfiles/nixos/modules/home-manager/hyprland/skyline.jpg"
        ];
        wallpaper = [
          ",~/dotfiles/nixos/modules/home-manager/hyprland/skyline.jpg"
        ];
      };
    };
  };
}
