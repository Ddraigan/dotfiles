{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  sys = pkgs.stdenv.hostPlatform.system;
in {
  options.modules.nix.desktop.hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  config = lib.mkIf config.modules.nix.desktop.hyprland.enable {
    environment = {
      systemPackages = [
        pkgs.hyprpolkitagent
      ];
      variables = {
        # UWSM manages these
        # XDG_CURRENT_DESKTOP = "Hyprland";
        # XDG_SESSION_TYPE = "wayland";
        # XDG_SESSION_DESKTOP = "Hyprland";
      };
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/leon/.steam/root/compatibilitytools.d";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        T_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
      inputs.dgop.follows = "dgop";
        WLR_NO_HARDWARE_CURSORS = "1";
      };
    };
    hardware.graphics = let
      hyprland-package-sync = inputs.hyprland.inputs.nixpkgs.legacyPackages.${sys};
    in {
      package = hyprland-package-sync.mesa;
      package32 = hyprland-package-sync.pkgsi686Linux.mesa;
    };
    programs = {
      uwsm = {
        enable = true;
      };
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${sys}.hyprland;
        portalPackage = inputs.hyprland.packages.${sys}.xdg-desktop-portal-hyprland;
      };
    };
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        common.default = ["gtk"];
        hyprland.default = ["hyprland" "gtk"];
      };
      extraPortals = [
        # pkgs.xdg-desktop-portal-hyprland # Home manager module provides this one
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
