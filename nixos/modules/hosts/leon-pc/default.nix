{config, ...}: {
  flake.modules.nixos."leon-pc" = {lib, ...}: {
    imports = with config.flake.modules.nixos; [
      audio
    ];
  };
}
