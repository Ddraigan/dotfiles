{ pkgs, lib, config, ... }:

{
  config = {
    home.packages = [
      pkgs.hyprpaper
    ];
    services.hyprpaper = {
      enable = true;
      settings = {
        # ipc = "off";
        preload = [
          "~/dotfiles/nixos/modules/home-manager/desktop/hypr/hyprpaper/skyline.jpg"
        ];
        wallpaper = [
          ",~/dotfiles/nixos/modules/home-manager/desktop/hypr/hyprpaper/skyline.jpg"
        ];
      };
    };
  };
}
