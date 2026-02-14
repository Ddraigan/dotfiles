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
      customColorScheme = with colours.stripped; {
        text = text;
        subtext = subtext1;
        main = transparentFriendlyColour;
        main-elevated = transparentFriendlyColour;
        highlight = surface0;
        highlight-elevated = surface1;
        sidebar = transparentFriendlyColour;
        player = transparentFriendlyColour;
        card = transparentFriendlyColour;
        shadow = mantle;
        selected-row = overlay2;
        button = overlay1;
        button-active = overlay2;
        button-disabled = overlay0;
        tab-active = surface1;
        notification = rosewater;
        notification-error = red;
        equalizer = transparentFriendlyColour;
        misc = surface1;
      };
    };
  };
}
