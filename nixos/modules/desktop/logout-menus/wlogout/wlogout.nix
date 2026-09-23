{...}: {
  homeManager.wlogout =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      config = {
        home.packages = [
          pkgs.librsvg
        ];
        xdg.configFile."wlogout/icons".source = ./icons;
        programs.wlogout = {
          enable = true;
          style = ''
            ${builtins.readFile ./style.css}
          '';
          layout = [
            {
              label = "lock";
              action = "uwsm app -- hyprlock";
              text = "Lock";
              keybind = "l";
            }
            {
              label = "logout";
              action = "uwsm stop";
              text = "Log Out";
              keybind = "e";
            }
            {
              label = "suspend";
              action = "systemctl suspend";
              text = "Suspend";
              keybind = "u";
            }
            {
              label = "reboot";
              action = "systemctl reboot";
              text = "Restart";
              keybind = "r";
            }
            {
              label = "shutdown";
              action = "systemctl poweroff";
              text = "Power Off";
              keybind = "s";
            }
            {
              label = "hibernate";
              action = "";
              text = "Hibernate";
              keybind = "";
            }
          ];
        };
      };
    };
}