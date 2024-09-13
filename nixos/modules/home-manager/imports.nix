{
  hyprland = import ./hyprland;
  rofi = import ./rofi;
  catppuccin = import ./catppuccin.nix;
  tmux = import ./tmux;
  wezterm = import ./wezterm;
  starship = import ./starship;
  zsh = import ./zsh;
  waybar = import ./hyprland/waybar.nix;
  neovim = import ./nvim.nix;
  zoxide = import ./zoxide.nix;
  hyprpaper = import ./hyprland/hyprpaper.nix;
}
