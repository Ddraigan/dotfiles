{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options.modules.desktop.ashell = {
    enable = lib.mkEnableOption "Enable Ashell";
  };
  # config = {
  #   programs.ashell = {
  #     enable = true;
  #     package = pkgs.unstable.ashell;
  #     settings = {
  #       log_level = "warn";
  #       position = "top";
  #       outputs = "all"; # Target monitors
  #       modules = {
  #         left = ["Clock" "SystemInfo"];
  #         center = ["Workspaces" "WindowTitle"];
  #         right = ["MediaPlayer" ["Privacy" "Tray" "Settings"]];
  #       };
  #       settings = {
  #         # lock_cmd = "playerctl --all-players pause; nixGL hyprlock &";
  #         audio_sinks_more_cmd = "pavucontrol -t 3";
  #         audio_sources_more_cmd = "pavucontrol -t 4";
  #         wifi_more_cmd = "nm-connection-editor";
  #         vpn_more_cmd = "nm-connection-editor";
  #         # bluetooth_more_cmd = "blueberry";
  #       };
  #       window_title = {
  #         truncate_title_after_length = 75;
  #       };
  #       # customModules = [
  #       #   {
  #       #     name = "MyCustom";
  #       #     icon = "";
  #       #     command = "echo hello";
  #       #     listen_cmd = "date +%H:%M";
  #       #   }
  #       # ];
  #       appearance = {
  #         font_name = config.global.home.fonts.mono.name;
  #         style = "Island";
  #         success_color = "#a6e3a1";
  #         text_color = "#cdd6f4";
  #
  #         workspace_colors = ["#fab387" "#b4befe" "#cba6f7"];
  #
  #         primary_color = {
  #           base = "#fab387";
  #           text = "#1e1e2e";
  #         };
  #
  #         danger_color = {
  #           base = "#f38ba8";
  #           weak = "#f9e2af";
  #         };
  #
  #         background_color = {
  #           base = "#1e1e2e";
  #           weak = "#313244";
  #           strong = "#45475a";
  #         };
  #
  #         secondary_color = {
  #           base = "#11111b";
  #           strong = "#1b1b25";
  #         };
  #       };
  #     };
  #   };
  # };
}
