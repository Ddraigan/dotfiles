{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  options.modules.desktop.spicetify.enable = lib.mkEnableOption "Enable Rofi";
  config = lib.mkIf config.modules.desktop.spicetify.enable {
    programs.spicetify = {
      enable = true;
      # enabledExtensions = with spicePkgs.extensions; [
      #   adblockify
      #   hidePodcasts
      #   shuffle # shuffle+ (special characters are sanitized out of extension names)
      # ];
      colorScheme = "custom";
      customColorScheme = {
        text = "cdd6f4";
        subtext = "CDD6F4";
        main = "1E1E2E00";
        main-elevated = "313244";
        highlight = "313344";
        highlight-elevated = "45475a";
        sidebar = "181825";
        player = "11111B00";
        card = "313244";
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

        crust = "11111B00";
        mantle = "18182500";
        base = "1E1E2E00";
        surface0 = "313244";
        surface1 = "45475A";
        surface2 = "585b70";
        overlay0 = "6C7086;";
        overlay1 = "7f849C";
        overlay2 = "9399B2";
        rosewater = "f5e0dc";
        flamingo = "f2cdcd";
        pink = "f5c2e7";
        maroon = "eba0ac";
        red = "f38ba8";
        peach = "fab387";
        yellow = "f9e2af";
        green = "a6e3a1";
        teal = "94e2d5";
        sapphire = "74c7ec";
        blue = "89b4fa";
        sky = "89dceb";
        mauve = "cba6f7";
        lavender = "b4befe";
      };
    };
  };
}
