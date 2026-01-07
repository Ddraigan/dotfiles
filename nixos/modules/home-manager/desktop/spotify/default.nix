{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  spicetify = inputs.spicetify-nix;
  spicetify_hm = spicetify.homeManagerModules.spicetify;
  spicePkgs = spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    spicetify_hm
  ];
  options.modules.desktop.spicetify.enable = lib.mkEnableOption "Enable Spicetify";
  config = lib.mkIf config.modules.desktop.spicetify.enable {
    programs.spotify-player = {
      enable = true;
    };
    programs.spicetify = {
      enable = true;
      wayland = true;
      experimentalFeatures = true;
      alwaysEnableDevTools = true;
      enabledExtensions = with spicePkgs.extensions; [
        keyboardShortcut
      ];
      enabledCustomApps = with spicePkgs.apps; [
        marketplace
      ];
      # theme = {
      #   name = "custom";
      #   src = ./custom;
      #   injectCss = true;
      #   injectThemeJs = false;
      #   replaceColors = true;
      #   homeConfig = true;
      #   overwriteAssets = true;
      #   # additonalCss = "";
      # };
      # theme = spicePkgs.themes.dribbblish;
      colorScheme = "custom";
      customColorScheme = {
        text = "cdd6f4";
        subtext = "CDD6F4";
        main = "000000";
        main-elevated = "000000";
        highlight = "313344";
        highlight-elevated = "45475a";
        sidebar = "000000";
        player = "000000";
        card = "000000";
        shadow = "181825";
        selected-row = "9399B2";
        button = "7F849C";
        button-active = "9399B2";
        button-disabled = "6C7086";
        tab-active = "313244";
        notification = "313244";
        notification-error = "F38BA8";
        equalizer = "000000";
        misc = "45475A";
      };
      # customColorScheme = {
      #   text = "cdd6f4";
      #   subtext = "CDD6F4";
      #   main = "1E1E2E";
      #   main-elevated = "313244";
      #   highlight = "313344";
      #   highlight-elevated = "45475a";
      #   sidebar = "181825";
      #   player = "11111B";
      #   card = "313244";
      #   shadow = "181825";
      #   selected-row = "9399B2";
      #   button = "7F849C";
      #   button-active = "9399B2";
      #   button-disabled = "6C7086";
      #   tab-active = "313244";
      #   notification = "313244";
      #   notification-error = "F38BA8";
      #   equalizer = "000000";
      #   misc = "45475A";
      # };
    };
  };
}
