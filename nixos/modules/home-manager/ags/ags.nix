{ inputs, pkgs, ... }:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  config = {
    programs.ags = {
      enable = true;
      # null or path, leave as null if you don't want hm to manage the config
      configDir = ../../../../ags;
      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
    # home.file = {
    #   ".config/ags" = {
    #     source = ../../../../ags;
    #   };
    # };
  };

}
