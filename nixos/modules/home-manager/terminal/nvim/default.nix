{ pkgs, lib, config, ... }:

{
  options.modules.terminal.nvim.enable = lib.mkEnableOption "Enable Nvim";
  config = lib.mkIf config.modules.terminal.nvim.enable {
    home.packages = [
      pkgs.unstable.neovim
    ];
    home.file = {
      ".config/nvim" = {
        source = ../../../../../nvim;
      };
    };
  };
}
