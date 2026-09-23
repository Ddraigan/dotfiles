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
        cmdline
        wezterm
        noctalia
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
