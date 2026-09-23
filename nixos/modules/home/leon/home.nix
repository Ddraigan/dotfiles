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
      ++ (with config.homeManager; [
        shared
        uwsm
        fonts
        stylix
        nvim
        wezterm
        cmdline
        noctalia
        gaming
        obs
        hyprland
        hyprlock
        hypridle
        nemo
        spicetify
        wlogout
        zen
      ]);
  };
}
