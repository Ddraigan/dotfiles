{...}: {
  flake.modules.nixos.quicksync =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      config = {
    boot = {
      kernelParams = ["i915.enable_guc=2"];
    };
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # intel-ocl
        intel-media-driver
        intel-compute-runtime-legacy1
      ];
    };
  };
};
}