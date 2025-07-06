{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.nvim.enable = lib.mkEnableOption "Enable Nvim";
  config = lib.mkIf config.modules.terminal.nvim.enable {
    # home.packages = [
    #   pkgs.neovim
    # ];
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      extraPackages = with pkgs; [
        fd
        ripgrep
        gcc
        gnumake
        nodejs_24
      ];
    };
    home.file = {
      ".config/nvim" = {
        source = ../../../../../nvim;
      };
    };
    # home.file.".config/nvim/lua/config/nixopts.lua" = {
    #   text = ''
    #     -- npm is required for mason
    #     vim.env.PATH = vim.env.PATH .. ":${pkgs.nodejs}/bin"
    #   '';
    # };
  };
}
