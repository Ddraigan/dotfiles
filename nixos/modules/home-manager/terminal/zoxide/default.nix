{ pkgs, lib, config, ... }:

{
  config = {
    home.packages = [
      pkgs.zoxide
    ];
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
