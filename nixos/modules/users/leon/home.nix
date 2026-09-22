{
  inputs,
  config,
  ...
}: {
  flake.homeConfigurations.leon = inputs.home-manager-unstable.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit inputs;
    };
    modules =
      [
        ./_host/home.nix
      ]
      ++ (with config.flake.modules.homeManager; [
        shared
        uwsm
        fonts
        stylix
        terminal-core
        nvim
        starship
        tmux
        wezterm
        zoxide
        eza
        zsh
        fastfetch
        noctalia
        gaming
        obs
        hyprland
        hyprlock
        hypridle
        mpv
        nemo
        spicetify
        wlogout
        zen
      ]);
  };
}
