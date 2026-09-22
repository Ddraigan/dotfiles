{
  inputs,
  config,
  ...
}: {
  flake.homeConfigurations.leon-dell = inputs.home-manager-unstable.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [
      ./_host/home.nix
      config.flake.modules.homeManager.shared
      config.flake.modules.homeManager.uwsm
      config.flake.modules.homeManager.fonts
      config.flake.modules.homeManager.stylix
      config.flake.modules.homeManager.terminal-core
      config.flake.modules.homeManager.nvim
      config.flake.modules.homeManager.starship
      config.flake.modules.homeManager.tmux
      config.flake.modules.homeManager.wezterm
      config.flake.modules.homeManager.zoxide
      config.flake.modules.homeManager.eza
      config.flake.modules.homeManager.zsh
      config.flake.modules.homeManager.fastfetch
      config.flake.modules.homeManager.noctalia
      config.flake.modules.homeManager.hyprland
      config.flake.modules.homeManager.hyprlock
      config.flake.modules.homeManager.hypridle
      config.flake.modules.homeManager.mpv
      config.flake.modules.homeManager.nemo
      config.flake.modules.homeManager.spicetify
      config.flake.modules.homeManager.wlogout
      config.flake.modules.homeManager.zen
    ];
  };
}