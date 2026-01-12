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
    icons = {
      enable = lib.mkEnableOption "custom icon theme configuration";
      name = lib.mkOption {
        type = lib.types.str;
        default = "Papirus-Dark";
        description = "Icon theme name";
      };
      package = lib.mkOption {
        type = lib.types.package;
        description = "Icon theme package";
      };
      size = lib.mkOption {
        type = lib.types.str;
        default = "32x32";
        description = "Icon size";
      };
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
    };
}
