{
  lib,
  config,
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
        enable32bit = true;
      };
      nvidia = {
        modesetting.enable = true; # Required
        powerManagement = {
          enable = false; # Can cause sleep suspend issues
          finegrained = false; # Can turn off GPU when not in use (unlikely to need this)
        };
        open = true; # Turing and later basically
        nvidiaSettings = true;
      };
    };
  };
}
