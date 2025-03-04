{ pkgs, lib, config, ... }:

{
  options.modules.desktop.waybar.enable = lib.mkEnableOption "Enable Waybar";
  config = lib.mkIf config.modules.desktop.waybar.enable {
    home.packages = with pkgs; [
      waybar
      rofi-bluetooth
      btop
      pavucontrol
      networkmanagerapplet
    ];
    catppuccin.waybar.enable = false; # Already in config
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style =
        ''
          ${builtins.readFile ./style.css}
        '';
      settings = [{
        layer = "top";
        modules-left = [
          # "custom/logo"
          "clock"
          "custom/weather"
          "disk"
          "memory"
          "cpu"
          "temperature"
          "custom/powerDraw"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          "custom/clipboard"
          "backlight"
          "bluetooth"
          "pulseaudio"
          "network"
          "battery"
        ];

        "custom/logo" = {
          format = "  ";
          tooltip = false;
        };

        "custom/powerDraw" = {
          format = "{}";
          interval = 1;
          exec = "./scripts/powerdraw.sh";
          return-type = "json";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "active" = "";
            "default" = "";
          };
        };

        "custom/weather" = {
          format = "{}";
          return-type = "json";
          exec = "~/.config/waybar/scripts/weather.sh";
          interval = 10;
          on-click = "firefox https://wttr.in";
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
          format-off = "";
          format-disabled = "󰂲";
          format-connected = "󰂴";
          format-connected-battery = "{device_battery_percentage}% 󰂴";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "rofi-bluetooth";
        };

        network = {
          format-wifi = " ";
          format-ethernet = "󰈁";
          format-disconnected = "";
          tooltip-format = "{ipaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  | {ipaddr}";
          tooltip-format-ethernet = "{ifname} | {ipaddr}";
          # TODO:
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
          format-icons = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        backlight = {
          device = "intel_backlight";
          format = "<span font='12'>{icon}</span>";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
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
          format = " {usage}%";
          min-length = 6;
          max-length = 6;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };

        memory = {
          format = " {percentage}%";
        };

        "hyprland/window" = {
          format = "( {class} )";
          rewrite = {
            "(.*) - Mozilla Firefox" = "🌎 $1";
            "(.*) - zsh" = "> [$1]";
            "(.*) - wezterm" = "> $1";
          };
        };

        temperature = {
          format = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
          interval = 1;
          critical-threshold = 80;
          on-click = "btop -lc";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "󰂰";
          format-muted = "<span font='12'></span>";
          format-icons = {
            headphones = "";
            bluetooth = "󰥰";
            handsfree = "";
            headset = "󱡬";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          justify = "center";
          on-click = "amixer sset Master toggle";
          on-click-right = "pavucontrol";
          tooltip-format = "{icon}  {volume}%";
        };

        tray = {
          icon-size = 14;
          spacing = 10;
        };

        upower = {
          show-icon = false;
          hide-if-empty = true;
          tooltip = true;
          tooltip-spacing = 20;
        };
      }];

    };

  };
}
