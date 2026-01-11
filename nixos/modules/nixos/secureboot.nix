# {
#   lib,
#   pkgs,
#   inputs,
#   ...
# }: {
#   imports = [
#     inputs.lanzaboote.nixosModules.lanzaboote
#   ];
#   config = {
#     environment = {
#       systemPackages = [
#         pkgs.sbctl
#       ];
#     };
#     boot = {
#       loader = {
#         systemd-boot.enable = lib.mkForce false;
#         efi.canTouchEfiVariables = true;
#       };
#       lanzaboote = {
#         enable = true;
#         pkiBundle = "/var/lib/sbctl";
#       };
#     };
#   };
# }
