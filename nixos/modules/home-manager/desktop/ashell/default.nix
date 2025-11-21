{
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.desktop.ashell = {
    enable = lib.mkEnableOption "Enable Ashell";
  };
  config = {
    programs.ashell = {
      enable = true;
      package = pkgs.unstable.ashell;
      settings = {
        position = "top";
        outputs = "all"; # Target monitors
        modules = {
          left = ["Clock" "SystemInfo" "Updates"];
          center = ["Workspaces" "WindowTitle"];
          right = ["MediaPlayer" ["Privacy" "Tray" "Settings"]];
        };
        # customModules = [
        #   {
        #     name = "MyCustom";
        #     icon = "";
        #     command = "echo hello";
        #     listen_cmd = "date +%H:%M";
        #   }
        # ];
        appearance = {
          font_name = config.global.fonts.active.mono.name;
          style = "Island";
        };
      };
    };
  };
}
