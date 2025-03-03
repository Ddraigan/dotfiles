{ pkgs, inputs, lib, config, ... }:

{
  options.modules.desktop.walker.enable = lib.mkEnableOption "Enable Waklker";

  config = lib.mkIf config.modules.desktop.walker.enable {
    programs = {
      walker = {
        enable = true;
        runAsService = true;
        config = {
          search.placeholder = "Search";
          ui = {
            fullscreen = true;
            window.box.width = 800;
          };
          list = {
            height = 800;
            maxEntries = 15;
            dynamicSub = true;
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
  };
}
