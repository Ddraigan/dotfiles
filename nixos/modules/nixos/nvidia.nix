{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.nix.nvidia.enable = lib.mkEnableOption "Enable nVidia graphics settings / drivers";
  config = lib.mkIf config.modules.nix.nvidia.enable {
    services.xserver = {
      videoDrivers = ["nvidia"];
    };
    hardware = {
      graphics = {
        enable = true; # Enable OpenGL
        enable32Bit = true;
        extraPackages = with pkgs; [
          vulkan-validation-layers
        ];
      };
      nvidia = {
        modesetting.enable = true; # Required
        powerManagement = {
          enable = false; # Often causes suspend / resume issues on desktops
          finegrained = false; # Mostly useful for laptops with iGPU/dGPU switching
        };
        open = true; # Turing and later basically
        nvidiaSettings = true;
      };
    };
    boot.kernelParams = [
      "nvidia-drm.modeset=1"
    ];
  };
}
