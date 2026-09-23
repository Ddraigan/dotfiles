{...}: {
  homeManager.fastfetch = {
    lib,
    pkgs,
    config,
    ...
  }: {
    config = {
      home.shellAliases = {
        cf = "clear && fastfetch";
      };
      programs.fastfetch = {
        enable = true;
        settings = {
          display = {
            separator = " ";
          };

          modules = [
            {
              type = "title";
              keyWidth = 10;
            }

            "break"

            {
              type = "os";
              key = "󱄅 ";
              keyColor = "34";
            }
            {
              type = "kernel";
              key = " ";
              keyColor = "34";
            }
            {
              type = "packages";
              key = " ";
              keyColor = "34";
            }
            {
              type = "shell";
              key = " ";
              keyColor = "34";
            }
            {
              type = "terminal";
              key = " ";
              keyColor = "34";
            }
            {
              type = "wm";
              key = " ";
              keyColor = "34";
            }
            {
              type = "display";
              key = " ";
              keyColor = "34";
            }
            {
              type = "cpu";
              format = "{1}";
              key = " ";
              keyColor = "34";
            }
            {
              type = "gpu";
              format = "{2}";
              key = " ";
              keyColor = "34";
            }
            {
              type = "gpu";
              format = "{3}";
              key = " ";
              keyColor = "34";
            }
            {
              type = "memory";
              key = "󰍛 ";
              keyColor = "34";
            }
            {
              type = "swap";
              key = "󰾴 ";
              keyColor = "34";
            }
            {
              type = "disk";
              key = " ";
              keyColor = "34";
            }
            {
              type = "uptime";
              key = " ";
              keyColor = "34";
            }
            {
              type = "command";
              key = "󱦟 ";
              keyColor = "34";
              text = ''
                birth_install=$(stat -c %W /)
                current=$(date +%s)
                time_progression=$((current - birth_install))
                days_difference=$((time_progression / 86400))
                echo $days_difference days
              '';
            }
          ];
        };
      };
    };
  };
}
