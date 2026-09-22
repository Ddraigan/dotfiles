{...}: {
  flake.modules.homeManager.zsh =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options.modules.terminal.zsh.primaryTerminal = lib.mkEnableOption "Set as primary terminal global value";

      config = {
        programs.zsh = {
          enable = true;
          syntaxHighlighting.enable = true;
          autosuggestion.enable = true;
          history = {
            expireDuplicatesFirst = true;
            ignoreDups = true;
          };
          initContent =
            #zsh
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