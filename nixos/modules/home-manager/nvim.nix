{ pkgs, outputs, lib, config, ... }: {
  config = {
    home.packages = [
      pkgs.unstable.neovim
    ];
    home.file = {
      ".config/nvim" = {
        source = ../../../nvim;
      };
    };
  };
}
