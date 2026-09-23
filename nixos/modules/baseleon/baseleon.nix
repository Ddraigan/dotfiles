{
  config,
  lib,
  ...
}: {
  nixos.baseleon = lib.mkMerge [
    config.nixos.locale
    ({
      lib,
      pkgs,
      config,
      inputs,
      ...
    }: {
      users = {
        defaultUserShell = pkgs.zsh;
        users = {
          leon = {
            isNormalUser = true;
            description = "Leon Jones";
            extraGroups = ["networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire" "docker" "gamemode" "kvm" "adbusers" "usbmux"];
            openssh.authorizedKeys.keys = let
              authorizedKeys = pkgs.fetchurl {
                url = "https://github.com/Ddraigan.keys";
                hash = "sha256-iWcX6b0Zx16Ndx+MaPu4CiuIsFR6JNf5apJhGSx8paI=";
              };
            in
              pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
          };
        };
      };

      nixpkgs = {
        overlays = [inputs.self.overlays.unstable-packages];
        config.allowUnfree = true;
      };

      nix = let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in {
        settings = {
          experimental-features = ["nix-command" "flakes"];
          nix-path = config.nix.nixPath;
        };
      };
    })
  ];

  homeManager.baseleon = {};
}