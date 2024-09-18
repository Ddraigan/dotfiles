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
          "~/Pictures/skyline.jpg"
        ];
        wallpaper = [
          "~/Pictures/skyline.jpg"
        ];
      };
    };
  };
}
