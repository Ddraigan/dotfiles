{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.waybar.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.modules.desktop.waybar.enable {
    home.packages = with pkgs; [
      # rofi-bluetooth
      blueman
      btop
      pavucontrol
      networkmanagerapplet
    ];
    # user.services.waybar.wantedBy = [ "graphical-session.target" ];
    # catppuccin.waybar.enable = false; # Already in config
    programs.waybar = {
      enable = true;
      systemd.enable = false;
      style = ''
        ${builtins.readFile ./style.css}
      '';
      settings = [
        {
          layer = "top";
          position = "top";
          mode = "dock";
          height = 32;
          exclusive = true;
          passthrough = false;
          # gtk-layer-shell = true;
          fixed-centre = true;
          # margin-top = 10;
          # margin-left = 10;
          # margin-right = 10;
          margin-bottom = -10;

          modules-left = [
            "clock"
            "custom/uptime"
            "cpu"
            "memory"
            "temperature"
          ];
          modules-center = [
            "hyprland/workspaces"
          ];
          modules-right = [
            "custom/music"
            "backlight"
            "bluetooth"
            "network"
            "wireplumber"
            "wireplumber#source"
            "tray"
            "custom/clipboard"
            "network"
            "battery"
          ];

          "hyprland/workspaces" = {
            format = "{name}:{icon}";
            format-icons = {
              active = "";
              default = "";
            };
          };

          "custom/music" = {
            format = "  {}";
            escape = true;
            interval = 5;
            tooltip = false;
            exec = "playerctl metadata --format='{{ artist }} - {{ title }}'";
            on-click = "playerctl play-pause";
            max-length = 50;
          };

          "custom/clipboard" = {
            format = "󰅍";
            on-click = "cliphist list | rofi -dmenu | cliphist decode | wl-copy";
            interval = 86400;
          };

          clock = {
            format = "{:%I:%M:%S %p}";
            interval = 1;
            tooltip-format = "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            calendar-weeks-pos = "right";
            today-format = "<span color='#7645AD'><b><u>{}</u></b></span>";
            format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
            format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
            format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";
          };

          bluetooth = {
            format-on = "";
            format-off = "󰂲";
            format-no-controller = "";
            format-disabled = "󰂲";
            format-connected = "󰂴";
            format-connected-battery = "{device_battery_percentage}% 󰂴";
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
            on-click = "blueman-manager";
          };

          network = {
            format-wifi = " ";
            format-ethernet = "󰈁";
            format-disconnected = "";
            tooltip-format = "{ipaddr}";
            tooltip-format-wifi = "{essid} ({signalStrength}%)  | {ipaddr}";
            tooltip-format-ethernet = "{ifname} | {ipaddr}";
            on-click = "networkmanager_dmenu";
          };

          battery = {
            interval = 1;
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{capacity}%  {icon} ";
            format-charging = "{capacity}% 󰂄 ";
            format-plugged = "{capacity}% 󰂄 ";
            format-alt = "{time} {icon}";
            format-icons = ["󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
          };

          backlight = {
            device = "intel_backlight";
            format = "<span font='12'>{icon}</span>";
            format-icons = ["" "" "" "" "" "" "" "" "" ""];
            on-scroll-down = "light -A 10";
            on-scroll-up = "light -U 10";
            smooth-scrolling-threshold = 1;
          };

          disk = {
            interval = 30;
            format = "  {percentage_used}%";
            path = "/";
          };

          cpu = {
            interval = 1;
            # format = " {usage}%";
            format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            on-click = "btop";
          };

          memory = {
            interval = 30;
            # format = " {percentage}%";
            format = "  {used:0.1f}G/{total:0.1f}G";
            tooltip-format = "Memory";
          };

          "hyprland/window" = {
            format = "( {} )";
            rewrite = {
              "(.*) - Mozilla Firefox" = "🌎 $1";
              "(.*) - zsh" = "> [$1]";
              "(.*) - wezterm" = "> $1";
            };
          };

          temperature = {
            hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            interval = 1;
            critical-threshold = 80;
            on-click = "btop -l";
          };

          wireplumber = {
            # on-scroll-up = "pw-volume change +2.0%";
            # on-scroll-down = "pw-volume change -2.0%";
            format = "{icon} {volume}%";
            format-muted = "";
            format-icons = {
              default = ["" "" ""];
            };
            justify = "center";
            # on-click = "TODO: mute"
            on-click-middle = "helvum";
            on-click-right = "pavucontrol";
            tooltip = true;
            tooltip-format = "{source_desc}";
          };

          "wireplumber#source" = {
            node-type = "Audio/Source";
            format = "󰍬 {volume}%";
            format-muted = "󰍭";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
            scroll-step = 5;
          };

          # pulseaudio = {
          #   format = "{volume}% {icon}";
          #   format-bluetooth = "󰂰";
          #   format-muted = "<span font='12'></span>";
          #   format-icons = {
          #     headphones = "";
          #     bluetooth = "󰥰";
          #     handsfree = "";
          #     headset = "󱡬";
          #     phone = "";
          #     portable = "";
          #     car = "";
          #     default = [ "" "" "" ];
          #   };
          #   justify = "center";
          #   on-click = "amixer sset Master toggle";
          #   on-click-right = "pavucontrol";
          #   tooltip-format = "{icon}  {volume}%";
          # };
          #
          tray = {
            icon-size = 16;
            spacing = 8;
          };

          upower = {
            show-icon = false;
            hide-if-empty = true;
            tooltip = true;
            tooltip-spacing = 20;
          };
        }
      ];
    };
  };
}
