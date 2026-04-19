{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.nvim.enable = lib.mkEnableOption "Enable Nvim";
  config = lib.mkIf config.modules.terminal.nvim.enable {
    home = {
      file = {
        ".config/nvim" = {
          source = ../../../../../nvim;
	  recursive = true;
        };
      };
    };
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      withRuby = false;
      withPython3 = true;
      defaultEditor = true;
      extraPackages = with pkgs; [
        fd
        ripgrep
        tree-sitter
	git
        gcc
        gnumake
        nodejs_24
        lua-language-server
        stylua
        libclang
      ];
    };
  };
}
