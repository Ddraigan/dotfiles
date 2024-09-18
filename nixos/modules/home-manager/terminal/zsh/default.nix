{ pkgs, lib, config, ... }:

{
  options.modules.terminal.zsh.enable = lib.mkEnableOption "Enable zsh";
  config = lib.mkIf config.modules.terminal.zsh.enable {
    home.packages = [
      pkgs.zsh
    ];
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
      };

      initExtra = ''
        # Auto attach to Tmux session or create a new session called default
        if ! { [ "$TERM" = "xterm-256color" ] && [ -n "$TMUX" ]; } then
          tmux new -As default
        fi
      '';
    };
  };
}
