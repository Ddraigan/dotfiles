{ pkgs, lib, config, ... }: {
  config = {
    home.packages = [
      pkgs.starship
    ];
    programs.starship = {
      enable = true;
      settings = {
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
          "$nodejs"
          "$golang"
          "$python"
          "$cmd_duration"
          "$line_break"
          "$character"
        ];
        hostname = {
          ssh_only = true;
          detect_env_vars = [ "SSH_CONNECTION" ];
        };
        fill = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
          format = "[$symbol$branch]($style) ";
        };
        git_status = {
          format = "([$ahead_behind]($style))";
          ahead = "[⇡$count](green)";
          diverged = "[⇡$ahead_count(green)][⇣$behind_count(red)]";
          behind = "[⇣$count(red)]";
        };
        git_state = {
          format = "\([$state( $progress_current/$progress_total)]($style)\) ";
          style = "bright-black";
        };
        git_metrics = {
          disabled = true;
        };
        nodejs = {
          format = "[$symbol($version )]($style)";
        };
        rust = {
          format = "[$symbol($version )]($style)";
        };
        golang = {
          format = "[$symbol($version )]($style)";
        };
        python = {
          format = "[$symbol$pyenv_prefix($version )(\($virtualenv\) )]($style)";
        };
      };
    };
  };
}
