{
  lib,
  config,
  ...
}: let
  cfg = config.modules.lib.uwsm;
in {
  options = {
    modules.lib.uwsm.enable = lib.mkEnableOption "Enable UWSM wrappers and configs";
  };
  config._module.args.uwsmUtils = {
    wrap = cmd:
      if cfg.enable
      then "uwsm app -- ${cmd}"
      else cmd;
    exit =
      if cfg.enable
      then "uwsm stop"
      else "exit";
    rofi =
      if cfg.enable
      then "rofi -show drun -run-command 'uwsm app -- {cmd}'"
      else "rofi -show drun";
  };
}
