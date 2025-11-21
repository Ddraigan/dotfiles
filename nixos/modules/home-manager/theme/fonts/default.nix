{
  lib,
  config,
  ...
}: let
  fontOption = {lib, ...}: {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        description = "Font namespace";
      };
      package = lib.mkOption {
        type = lib.types.package;
        description = "Font package";
      };
    };
  };
in {
  options.global.home.fonts = {
    enable = lib.mkEnableOption "Enable global home manager font management";
    mono = lib.mkOption {
      type = lib.types.submodule fontOption;
      description = "Monospace primary font.";
    };
    sans = lib.mkOption {
      type = lib.types.submodule fontOption;
      description = "Sans primary font.";
    };
    serif = lib.mkOption {
      type = lib.types.submodule fontOption;
      description = "Serif primary font.";
    };
  };
  config = let
    cfg = config.global.home.fonts;
  in
    lib.mkIf cfg.enable {
      home.packages = builtins.map (x: x.package) [
        cfg.mono
        cfg.sans
        cfg.serif
      ];
      fonts.fontconfig.enable = true;
      # global.home.fonts.active = {
      #   mono = cfg.mono;
      #   sans = cfg.sans;
      #   serif = cfg.serif;
      # };
    };
}
