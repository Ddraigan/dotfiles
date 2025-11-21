{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.waybar.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.modules.desktop.waybar.enable {
    home.packages = with pkgs; [
      blueman
      btop
      pavucontrol
      networkmanagerapplet
    ];
    programs.waybar = let
      colours = config.global.theme.colours.catppuccin.mocha;
    in  {
      enable = true;
      systemd.enable = false;
      style = ''
        ${builtins.readFile ./style_new.css}
      '';
      settings = [
        {
          layer = "top";
          position = "top";
          mode = "dock";
          height = 32;
          exclusive = true;
          passthrough = false;
          fixed-centre = true;
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
            "bluetooth"
            "network"
            # "wireplumber#sink"
            # "wireplumber#source"
            "wireplumber"
            "tray"
            "custom/clipboard"
            "backlight"
            "battery"
          ];

          "hyprland/workspaces" = {
            format = "{name}:{icon}";
            format-icons = {
              active = "";
              default = "";
            };
          };

          # cava = {
          #   framerate = 15;
          #   method = "pipewire";
          #   bars = 16;
          #   format = "♪ {}";
          #   on-click-middle = "playerctl play-pause";
          #   on-click-right = "playerctl next";
          #   on-click-left = "playerctl previous";
          #   format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          # };

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
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#f2cdcd'><b>{}</b></span>";
                days = "<span color='#f5e0dc'><b>{}</b></span>";
                weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
                weekdays = "<span color='#f9e2af'><b>{}</b></span>";
                today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
            };
            # tooltip-format = "\n<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            # calendar-weeks-pos = "right";
            # today-format = "<span color='#cba6f7'><b><u>{}</u></b></span>";
            # format-calendar = "<span color='#aeaeae'><b>{}</b></span>";
            # format-calendar-weeks = "<span color='#aeaeae'><b>W{:%V}</b></span>";
            # format-calendar-weekdays = "<span color='#aeaeae'><b>{}</b></span>";
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
            tooltip-format-ethernet = "{essid}\n{ifname} | {ipaddr}";
            on-click = "nm-connection-editor";
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
            format = "  {icon0}{icon1}{icon2}{icon3}{usage:>2}%";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            on-click = "btop";
          };

          memory = {
            interval = 30;
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

          "wireplumber" = {
            format = "{icon} {volume}%";
            format-muted = "";
            format-icons = {
              default = ["" "" ""];
            };
            justify = "center";
            max-volume = 150;
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            on-click-middle = "helvum";
            on-click-right = "pavucontrol";
            tooltip = true;
            tooltip-format = "{node_name}";

            format-source = "󰍬 {source_volume}%";
            format-source-muted = "󰍭";
          };

          # "wireplumber#sink" = {
          #   format = "{icon} {volume}%";
          #   format-muted = "";
          #   format-icons = {
          #     default = ["" "" ""];
          #   };
          #   justify = "center";
          #   max-volume = 150;
          #   on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          #   on-click-middle = "helvum";
          #   on-click-right = "pavucontrol";
          #   tooltip = true;
          #   tooltip-format = "{source_desc}";
          # };
          #
          # "wireplumber#source" = {
          #   node-type = "Audio/Source";
          #   format = "󰍬 {volume}%";
          #   format-muted = "󰍭";
          #   on-click-right = "pwvucontrol";
          #   on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          #   on-scroll-down = "wpctl set-volume @DEFAULT_SOURCE@ 1%-";
          #   on-scroll-up = "wpctl set-volume @DEFAULT_SOURCE@ 1%+";
          #   scroll-step = 1;
          # };

          tray = {
            icon-size = 16;
            spacing = 8;
          };

          # upower = {
          #   show-icon = false;
          #   hide-if-empty = true;
          #   tooltip = true;
          #   tooltip-spacing = 20;
          # };
        }
      ];
    };
  };
}
