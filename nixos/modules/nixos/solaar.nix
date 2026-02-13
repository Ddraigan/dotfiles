{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  cfg = config.modules.nix.solaar;
in {
  imports = [
    inputs.solaar.nixosModules.default
  ];
  options = {
    modules.nix.solaar.enable = lib.mkEnableOption "Enable Solaar";
  };
  # Logitech peripheral stuff
  config = lib.mkIf cfg.enable {
    services.solaar = {
      enable = true; # Enable the service
      # package = pkgs.solaar; # The package to use
      # window = "hide"; # Show the window on startup (show, *hide*, only [window only])
      # batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
      # extraArgs = ""; # Extra arguments to pass to solaar on startup
    };
  };
}
