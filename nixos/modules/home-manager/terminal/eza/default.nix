{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.eza.enable = lib.mkEnableOption "Enable Eza";
  config = lib.mkIf config.modules.terminal.eza.enable {
    home.shellAliases = {
      ls = "eza";
    };
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      icons = true;
    };
  };
}
