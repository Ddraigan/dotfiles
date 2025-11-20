{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.nvim.enable = lib.mkEnableOption "Enable Nvim";
  config = lib.mkIf config.modules.terminal.nvim.enable {
    home = {
      sessionVariables = {
        EDITOR = "nvim";
      };
      file = {
        ".config/nvim" = {
          source = ../../../../../nvim;
        };
      };
    };
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      extraPackages = with pkgs; [
        fd
        ripgrep
        gcc
        gnumake
        nodejs_24
        lua-language-server
        stylua
      ];
    };
  };
}
