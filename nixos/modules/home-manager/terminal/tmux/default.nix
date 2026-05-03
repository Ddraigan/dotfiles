{
  pkgs,
  lib,
  config,
  ...
}: let
  userHome = config.home.homeDirectory;
in  {
  options.modules.terminal.tmux.enable = lib.mkEnableOption "Enable Tmux";
  config = lib.mkIf config.modules.terminal.tmux.enable {
    home.packages = [
      pkgs.tmux
    ];
    programs.tmux = {
      enable = true;
      prefix = "C-Space";
      terminal = "tmux-256color";
      escapeTime = 0;
      baseIndex = 1;
      mouse = true;
      keyMode = "vi";

      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"

            set -g @catppuccin_window_default_text '#W'
            set -g @catppuccin_window_current_text '#W'
            set -g @catppuccin_date_time_text ' %d.%m'
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
        # Colours
        set-option -ga terminal-overrides ",xterm-256color:Tc"

        # QOL
        set-option -g status-interval 5
        set-option -g automatic-rename on

        # Dynamic Rename
        set -g automatic-rename on
        set -g automatic-rename-format "#{s|${userHome}|~|:pane_current_path}"

        # Transparent Background
        set -g status-style "bg=default"
        set -g status-bg default

        # Alt vim keys to switch windows
        bind -n M-h previous-window
        bind -n M-l next-window

        # Quick Reload
        bind r source-file ~/.config/tmux/tmux.conf \; display "Config Reloaded!"

        # Tmux status bar at the top
        set -g status-position top

        bind v split-window -h -c "#{pane_current_path}"
        bind h split-window -v -c "#{pane_current_path}"

        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
  };
}
