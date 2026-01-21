{
  pkgs,
  lib,
  config,
  inputs,
  colours,
  ...
}: let
  spicetify = inputs.spicetify-nix;
  spicetify_hm = spicetify.homeManagerModules.spicetify;
  spicePkgs = spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  cols = colours.stripped;
  transparentFriendlyColour = "000000";
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
      colorScheme = "custom";
      customColorScheme = {
        text = cols.text;
        subtext = cols.subtext1;
        main = transparentFriendlyColour;
        main-elevated = transparentFriendlyColour;
        highlight = cols.surface0;
        highlight-elevated = cols.surface1;
        sidebar = transparentFriendlyColour;
        player = transparentFriendlyColour;
        card = transparentFriendlyColour;
        shadow = cols.mantle;
        selected-row = cols.overlay2;
        button = cols.overlay1;
        button-active = cols.overlay2;
        button-disabled = cols.overlay0;
        tab-active = cols.surface1;
        notification = cols.rosewater;
        notification-error = cols.red;
        equalizer = transparentFriendlyColour;
        misc = cols.surface1;
      };
    };
  };
}
