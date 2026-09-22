{...}: {
  flake.modules.homeManager.cmdline =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
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
