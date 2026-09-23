{...}: {
  homeManager.hyprpaper =
    {
      pkgs,
      lib,
      config,
      ...
    }:
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
              # "~/dotfiles/nixos/modules/desktop/desktop-environments/hyprland/hyprpaper/skyline.jpg"
              "~/dotfiles/nixos/modules/desktop/desktop-environments/hyprland/hyprpaper/wp_1.jpg"
            ];
            wallpaper = [
              # ",~/dotfiles/nixos/modules/desktop/desktop-environments/hyprland/hyprpaper/skyline.jpg"
              ",~/dotfiles/nixos/modules/desktop/desktop-environments/hyprland/hyprpaper/wp_1.jpg"
            ];
          };
        };
      };
    };
}