{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.nix.quicksync.enable = lib.mkEnableOption "Enable Intel QucikSync";
  config = lib.mkIf config.modules.nix.quicksync.enable {
    boot.loader = {
      kernelParams = ["i915.enable_guc=2"];
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-ocl
        intel-media-driver
      ];
    };
  };
}
