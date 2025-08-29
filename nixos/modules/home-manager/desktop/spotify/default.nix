{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  options.modules.desktop.spicetify.enable = lib.mkEnableOption "Enable Spicetify";
  config = lib.mkIf config.modules.desktop.spicetify.enable {
    programs.spicetify = {
      enable = true;
      wayland = true;
      experimentalFeatures = true;
      alwaysEnableDevTools = true;
      # enabledExtensions = with spicePkgs.extensions; [
      #   adblockify
      #   hidePodcasts
      #   shuffle # shuffle+ (special characters are sanitized out of extension names)
      # ];
      # theme = {
      #   name = "catppuccin-custom";
      #   src = ./catppuccin;
      #   injectCss = true;
      #   injectThemeJs = false;
      #   replaceColors = true;
      #   homeConfig = true;
      #   overwriteAssets = true;
      #   # additonalCss = "";
      # };
      # colorScheme = "mocha";

      theme = spicePkgs.themes.hazy;
      # theme = {
      #   name = "hazy-custom";
      #   src = ./hazy;
      #   injectCss = true;
      #   injectThemeJs = true;
      #   replaceColors = true;
      #   homeConfig = true;
      #   overwriteAssets = true;
      #   # additonalCss = "";
      # };
    };
  };
}
