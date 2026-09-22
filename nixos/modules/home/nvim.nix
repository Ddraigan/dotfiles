{...}: {
  flake.modules.homeManager.nvim =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.modules.terminal.nvim.primaryTerminal = lib.mkEnableOption "Set as primary terminal global value";

      config = {
        home = {
          file = {
            ".config/nvim" = {
              source = ../../../nvim;
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
    };
}