{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.zoxide.enable = lib.mkEnableOption "Enable Zoxide";
  config = lib.mkIf config.modules.terminal.zoxide.enable {
    home.shellAliases = {
      cd = "z";
    };
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
