{config, ...}: {
  flake.modules.nixos."leon-dell" = {lib, ...}: {
    imports = with config.flake.modules.nixos; [
      audio
    ];
  };
}
