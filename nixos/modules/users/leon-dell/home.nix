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
      config.flake.modules.homeManager.nvim
      config.flake.modules.homeManager.cmdline
      config.flake.modules.homeManager.wezterm
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
