{...}: {
  homeManager.uwsm =
    {
      lib,
      config,
      ...
    }:
    {
      config._module.args.uwsmUtils = {
        wrap = cmd: "uwsm app -- ${cmd}";
        exit = "uwsm stop";
        rofi = "rofi -show drun -run-command 'uwsm app -- {cmd}'";
      };
    };
}