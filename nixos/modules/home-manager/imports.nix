{
  hyprland = import ./hyprland/hyprland.nix;
  # ags = import ./ags;
  rofi = import ./rofi;
  catppuccin = import ./catppuccin.nix;
  tmux = import ./tmux/tmux.nix;
  wezterm = import ./wezterm/wezterm.nix;
  starship = import ./starship/starship.nix;
  zsh = import ./zsh/zsh.nix;
  waybar = import ./hyprland/waybar.nix;
  neovim = import ./nvim.nix;
  zoxide = import ./zoxide.nix;
  hyprpaper = import ./hyprland/hyprpaper.nix;
}
