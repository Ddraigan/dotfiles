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
              # "~/dotfiles/nixos/modules/hyprpaper/skyline.jpg"
              "~/dotfiles/nixos/modules/hyprpaper/wp_1.jpg"
            ];
            wallpaper = [
              # ",~/dotfiles/nixos/modules/hyprpaper/skyline.jpg"
              ",~/dotfiles/nixos/modules/hyprpaper/wp_1.jpg"
            ];
          };
        };
      };
    };
}