{...}: {
  flake.modules.homeManager.mpv =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      config = {
        programs.mpv = {
          enable = true;
        };
      };
    };
}