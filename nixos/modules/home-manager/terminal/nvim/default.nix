{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.nvim.enable = lib.mkEnableOption "Enable Nvim";
  config = lib.mkIf config.modules.terminal.nvim.enable {
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
    home.file = {
      ".config/nvim" = {
        source = ../../../../../nvim;
      };
    };
  };
}
