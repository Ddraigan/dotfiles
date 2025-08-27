{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.terminal.tmux.enable = lib.mkEnableOption "Enable Tmux";
  config = lib.mkIf config.modules.terminal.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];
    # catppuccin.tmux.enable = false; # Already in config
    programs.tmux = {
      enable = true;
      prefix = "C-Space";
      terminal = "xterm-256color";
      escapeTime = 0;
      baseIndex = 1;
      mouse = true;

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"
            # set -g @catppuccin_status_background "theme"

              # set -g @catppuccin_window_status_style "custom"
              # set -g @catppuccin_window_left_separator " "
              # set -g @catppuccin_window_right_separator " "
              # set -g @catppuccin_window_middle_separator " "

              # set-window-option -g window-status-current-style "fg=#{@thm_pink}"
              # set-window-option -g window-status-style "fg=#{@thm_overlay_2}"

            set -g @catppuccin_window_default_text '#W'
            set -g @catppuccin_window_current_text '#W'
            set -g @catppuccin_date_time_text ' %d.%m'

            # set -g @catppuccin_application_icon ""
          '';
        }
        {
          plugin = tmuxPlugins.vim-tmux-navigator;
          extraConfig = ''
            # set vi-mode
            set-window-option -g mode-keys vi
          '';
        }
        {
          plugin = tmuxPlugins.yank;
          extraConfig = ''
            # keybindings
            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
            bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          '';
        }
        tmuxPlugins.sensible
      ];

      extraConfig = ''
        set-option -g status-interval 5
        set-option -g automatic-rename on
        set -g automatic-rename-format "#{s|/home/user/||:pane_current_path}"
        # set-option -g automatic-rename-format '#{b:pane_current_path}'

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

        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"

        set -g status-left ""
        set -g status-left-length 100
        set -g status-right-length 100
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
  };
}
