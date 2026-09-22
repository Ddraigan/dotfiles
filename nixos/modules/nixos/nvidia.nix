{...}: {
  flake.modules.nixos.nvidia =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
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
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          modesetting.enable = true; # Required
          powerManagement = {
            enable = false; # Often causes suspend / resume issues on desktops
            finegrained = false; # Mostly useful for laptops with iGPU/dGPU switching
          };
          open = true; # Turing and later basically
          nvidiaSettings = true;
        };
      };
      boot.kernelModules = [
        "ntsync"
      ];
    };
}