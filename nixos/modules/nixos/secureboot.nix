{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  # imports = [
  #   inputs.lanzaboote.nixosModules.lanzaboote
  # ];
  options.modules.nix.secureboot.enable = lib.mkEnableOption "Enable secure boot";
  # config = lib.mkIf config.modules.nix.secureboot.enable {
  #   environment = {
  #     systemPackages = [
  #       pkgs.sbctl
  #     ];
  #   };
  #   boot = {
  #     loader = {
  #       systemd-boot.enable = lib.mkForce false;
  #       efi.canTouchEfiVariables = true;
  #     };
  #     lanzaboote = {
  #       enable = true;
  #       pkiBundle = "/var/lib/sbctl";
  #     };
  #   };
  # };
}
