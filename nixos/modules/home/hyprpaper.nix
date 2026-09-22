{...}: {
  flake.modules.homeManager.hyprpaper =
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
              # "~/dotfiles/nixos/modules/home/hyprpaper/skyline.jpg"
              "~/dotfiles/nixos/modules/home/hyprpaper/wp_1.jpg"
            ];
            wallpaper = [
              # ",~/dotfiles/nixos/modules/home/hyprpaper/skyline.jpg"
              ",~/dotfiles/nixos/modules/home/hyprpaper/wp_1.jpg"
            ];
          };
        };
      };
    };
}