{ pkgs, lib, config, ... }:

{
  options.modules.terminal.tmux.enable = lib.mkEnableOption "Enable Tmux";
  config = lib.mkIf config.modules.terminal.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];
    catppuccin.tmux.enable = false; # Already in config
    programs.tmux = {
      enable = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      escapeTime = 0;
      baseIndex = 1;
      mouse = true;
      extraConfig = ''
        set-option -g status-interval 5
        set-option -g automatic-rename on
        set-option -g automatic-rename-format '#{b:pane_current_path}'

        # Transparent Background
        set -g status-style "bg=default"
        set -g status-bg default

        # Vim style pane selection
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Alt vim keys to switch windows
        bind -n M-h previous-window
        bind -n M-l next-window

        # Tmux at the top
        set -g status-position top

        # set vi-mode
        set-window-option -g mode-keys vi

        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"
      '';

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_left_separator ""
            set -g @catppuccin_window_right_separator ""
            set -g @catppuccin_window_middle_separator " "
            # set -g @catppuccin_window_current_middle_separator "█"
            set -g @catppuccin_window_number_position "right"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_color "green"
            # set -g @catppuccin_window_default_background ""
            set -g @catppuccin_window_default_text "#W"

            set -g @catppuccin_window_current_left_separator ""
            set -g @catppuccin_window_current_middle_separator " "
            # set -g @catppuccin_window_current_middle_separator "█"
            set -g @catppuccin_window_current_right_separator ""

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_color "magenta"
            # set -g @catppuccin_window_current_background ""
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules_right "application session"
            set -g @catppuccin_status_background "theme"
            set -g @catppuccin_status_left_separator  ""
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_application_icon ""
          '';
        }
        {
          plugin = tmuxPlugins.vim-tmux-navigator;
          extraConfig =
            ''
              # set vi-mode
              set-window-option -g mode-keys vi
            '';
        }
        {
          plugin = tmuxPlugins.yank;
          extraConfig =
            ''
              # keybindings
              bind-key -T copy-mode-vi v send-keys -X begin-selection
              bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
              bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
            '';
        }
        tmuxPlugins.sensible
      ];
    };
  };
}
