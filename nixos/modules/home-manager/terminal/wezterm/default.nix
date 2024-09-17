{ pkgs, lib, config, ... }: {
  config = {
    home.packages = [
      pkgs.wezterm
    ];

    home.file = {
      ".config/wezterm" = {
        source = ../../../../../wezterm;
      };
    };
  };
}
