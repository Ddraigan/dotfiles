{
  hyprland = import ./hyprland/hyprland.nix;
  tmux = import ./tmux/tmux.nix;
  wezterm = import ./wezterm/wezterm.nix;
  starship = import ./starship/starship.nix;
  zsh = import ./zsh/zsh.nix;
  waybar = import ./hyprland/waybar.nix;
  neovim = import ./nvim.nix;
}
