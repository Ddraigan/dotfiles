{pkgs, inputs, lib, config, colours, ...}:
let
cfg = config.modules.desktop.noctalia;
in 
{
  imports = [
    inputs.noctalia.homeModules.default
  ];
  options.modules.desktop.noctalia = {
    enable = lib.mkEnableOption "Enable Noctalia Shell";
  };
  config = lib.mkIf cfg.enable {
    enable = true;
    colors = let
      hex = colours.hex;
    in  {
      mError = hex.red;
      mOnError = hex.text;
      mOnPrimary = hex.text;
      mOnSecondary = hex.text;
      mOnSurface = hex.text;
      mOnSurfaceVariant = hex.text;
      mOnTertiary = hex.text;
      mOnHover = hex.text;
      mOutline = hex.crust;
      mPrimary = hex.mauve;
      mSecondary = hex.maroon;
      mShadow = hex.crust;
      mSurface = hex.surface0;
      mHover = hex.base;
      mSurfaceVariant = hex.surface3;
      mTertiary = hex.pink;
    };
  };
}
