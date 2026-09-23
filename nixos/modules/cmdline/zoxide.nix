{...}: {
  homeManager.zoxide = {
    pkgs,
    lib,
    config,
    ...
  }: {
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