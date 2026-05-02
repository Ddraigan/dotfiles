{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.starship.enable = lib.mkEnableOption "Enable Starship";
  config = lib.mkIf config.modules.terminal.starship.enable {
    programs.starship = {
      enable = true;
      settings = let
        lang_format = "[$symbol($version )]($style)";
      in {
        add_newline = false;
        format = pkgs.lib.concatStrings [
          "$hostname"
          "$hostfile"
          "$directory"
          "$git_branch"
          "$git_commit"
          "$git_state"
          "$git_metrics"
          "$git_status"
          "$fill"
          "$nix_shell"
          "$rust"
          "$lua"
          "$haskell"
          "$nodejs"
          "$golang"
          "$python"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];
        hostname = {
          ssh_only = true;
          detect_env_vars = ["SSH_CONNECTION"];
        };
        fill = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
          format = "[$symbol$branch]($style) ";
        };
        git_status = {
          format = "[$ahead_behind]($style)";
          ahead = "[(⇡$count)](green)";
          diverged = "[(⇡$ahead_count(green)⇣$behind_count(red))]";
          behind = "[(⇣$count)](red)";
        };
        git_state = {
          format = "\([$state( $progress_current/$progress_total)]($style)\) ";
          style = "bright-black";
        };
        git_metrics = {
          disabled = true;
        };
        nodejs = {
          format = lang_format;
        };
        rust = {
          format = lang_format;
        };
        golang = {
          format = lang_format;
        };
        nix_shell = {
          symbol = "󱄅 ";
          format = "[$symbol$state( \($name\))]($style) ";
          heuristic = true;
        };
        haskell = {
          format = lang_format;
        };
        lua = {
          format = lang_format;
        };
        python = {
          format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style) ";
        };
      };
    };
  };
}
