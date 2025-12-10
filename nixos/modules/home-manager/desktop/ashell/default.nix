{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.modules.desktop.ashell = {
    enable = lib.mkEnableOption "Enable Ashell";
  };
  config = lib.mkIf config.modules.desktop.ashell.enable {
    # home.packages = [
    #   pkgs.unstable.ashell
    # ];
    programs.ashell = {
      enable = true;
      # package = pkgs.unstable.ashell;
      # package = inputs.ashell.defaultPackage.${pkgs.system};
      settings = {
        log_level = "Info";
        position = "Top";
        outputs = "All"; # Target monitors
        modules = {
          left = ["Clock" "SystemInfo"];
          center = ["Workspaces" "WindowTitle"];
          right = ["MediaPlayer" ["Privacy" "Tray" "Settings"]];
        };
        settings = {
          # lock_cmd = "playerctl --all-players pause; nixGL hyprlock &";
          audio_sinks_more_cmd = "pavucontrol -t 3";
          audio_sources_more_cmd = "pavucontrol -t 4";
          wifi_more_cmd = "nm-connection-editor";
          vpn_more_cmd = "nm-connection-editor";
          # bluetooth_more_cmd = "blueberry";
        };
        window_title = {
          truncate_title_after_length = 75;
        };
        # customModules = [
        #   {
        #     name = "MyCustom";
        #     icon = "";
        #     command = "echo hello";
        #     listen_cmd = "date +%H:%M";
        #   }
        # ];
        appearance = let
          font = config.global.home.fonts.mono;
          col = config.global.theme.colours.catppuccin.mocha;
        in {
          font_name = font.name;
          success_color = "#${col.green}";
          text_color = "#${col.text}";

          workspace_colors = ["#${col.peach}" "#${col.mauve}" "#${col.pink}"];

          primary_color = {
            base = "#${col.mauve}";
            text = "#${col.mantle}";
          };

          danger_color = {
            base = "#${col.red}";
            weak = "#${col.yellow}";
          };

          background_color = {
            base = "#${col.mantle}";
            weak = "#${col.base}";
            strong = "#${col.crust}";
          };

          secondary_color = {
            base = "#${col.crust}";
            strong = "#${col.mantle}";
          };
        };
      };
    };
  };
}
