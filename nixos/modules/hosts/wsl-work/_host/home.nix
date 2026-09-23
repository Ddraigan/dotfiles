{
  inputs,
  config,
  pkgs,
  ...
}: {
  dconf.enable = false;

  home = {
    stateVersion = "24.05";
    packages = [
      pkgs.just
      inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.dgop

      pkgs.opencode

      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
    ];

    shellAliases = {
      byebyewindows = "export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c/' | tr '\n' ':')";
    };
  };
}
