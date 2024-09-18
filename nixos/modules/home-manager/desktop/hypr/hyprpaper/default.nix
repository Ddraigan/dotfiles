{ pkgs, lib, config, ... }:

{
  options.modules.desktop.hypr.hyprpaper.enable = lib.mkEnableOption "Enable HyprPaper";
  config = lib.mkIf config.modules.desktop.hypr.hyprpaper.enable {
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
