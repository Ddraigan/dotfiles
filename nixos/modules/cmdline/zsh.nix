{...}: {
  flake.modules.homeManager.cmdline = {
    pkgs,
    lib,
    config,
    ...
  }: {
    config = {
      home.shellAliases = {
        steamos = "uwsm app -- gamescope -W 2560 -H 1440 -- steam -steamos3 -gamepadui -steamdeck -steampal";
      };
      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        history = {
          expireDuplicatesFirst = true;
          ignoreDups = true;
        };
        initContent =
          #sh
          ''
            tty=$(tty)
            if [[ $tty == "/dev/pts/0" ]]; then
              if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
                tmux new-session -A -s main "zsh -c 'fastfetch; exec zsh'"
              fi
            fi
          '';
      };
    };
  };
}
