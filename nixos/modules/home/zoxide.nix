{...}: {
  flake.modules.homeManager.zoxide =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.modules.terminal.zoxide.primaryTerminal = lib.mkEnableOption "Set as primary terminal global value";

      config = {
        home.shellAliases = {
          cd = "z";
        };
        programs.zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
      };
    };
}