{
  lib,
  config,
  ...
}: {
  options.modules.desktop.walker.enable = lib.mkEnableOption "Enable Waklker";

  config = lib.mkIf config.modules.desktop.walker.enable {
    programs.walker = {
      enable = true;
      runAsService = true;
      config = {
        search.placeholder = "Search";
        app_launch_prefix = "uwsm app -- ";
        ui = {
          fullscreen = true;
          window.box.width = 800;
        };
        list = {
          height = 800;
          max_entries = 15;
          dynamic_sub = true;
        };
        keys = {
          next = "ctrl n";
          prev = "ctrl p";
        };
        websearch.prefix = "?";
        switcher.prefix = "/";
      };
    };
  };
}
