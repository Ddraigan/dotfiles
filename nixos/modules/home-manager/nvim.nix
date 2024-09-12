{ pkgs, outputs, lib, config, ... }: {
  config = {
    home.packages = [
      pkgs.unstable.neovim
    ];
    programs.neovim.enable = true;
    home.file = {
      ".config/nvim" = {
        source = ../../../nvim;
      };
    };
  };
}
