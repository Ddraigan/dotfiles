{ inputs, pkgs, lib, ... }:

{
  # imports = [
  #   inputs.ags.homeManagerModules.default
  # ];
  options.ags.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable AGS";
  };
  config = lib.mkIf config.ags.enable {
    programs.ags = {
      enable = false;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
    home = {
      file = {
        ".config/ags/" = {
          source = ./ags;
        };
      };
    };
  };
}
