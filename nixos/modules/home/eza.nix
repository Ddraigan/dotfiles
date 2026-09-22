{...}: {
  flake.modules.homeManager.eza =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.modules.terminal.eza.primaryTerminal = lib.mkEnableOption "Set as primary terminal global value";

      config = {
        home.shellAliases = {
          ls = "eza";
        };
        programs.eza = {
          enable = true;
          enableZshIntegration = true;
          icons = "auto";
        };
      };
    };
}