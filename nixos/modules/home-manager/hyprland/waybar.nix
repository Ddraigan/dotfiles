{ pkgs, lib, config, ... }:

{
  config = {
    home.packages = [
      pkgs.waybar
    ];
    programs.waybar = {
      enable = true;
      catppuccin.enable = false; # Already in config
      systemd.enable = true;
      style =
        ''
          ${builtins.readFile ./waybar-style.css}
        '';
      settings = [{
        height = 30;
        layer = "top";
        position = "top";
        tray = { spacing = 10; };
        modules-left = [
          "clock#1"
          "clock#2"
          "clock#3"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "pulseaudio"
          "memory"
          "cpu"
          "disk"
          "battery"
          "temperature"
          # "network"
          "tray"
        ];
        "custom/left-arrow-dark" = {
          # format = "";
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          # format = "";
          format = "";
          tooltip = false;
        };
        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };
        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#3" = {
          format = "{:%d-%m}";
          tooltip = false;
        };
        battery = {
          format = "{capacity}% {icon}";
          format-alt = "{time} {icon}";
          format-charging = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
          format-plugged = "{capacity}% ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = { format = "{}% "; };
        network = {
          interval = 1;
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
          format-linked = "{ifname} (No IP) ";
          format-wifi = "{essid} ({signalStrength}%) ";
          on-click = "nm-applet";
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-icons = {
            car = "";
            default = [ "" "" "" ];
            handsfree = "";
            headphones = "";
            headset = "";
            phone = "";
            portable = "";
          };
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "" "" "" ];
        };
      }];

    };

  };
}
