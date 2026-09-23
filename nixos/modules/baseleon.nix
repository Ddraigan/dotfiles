{...}: {
  flake.modules.nixos.baseleon = {
    pkgs,
    config,
    lib,
    inputs,
    ...
  }: {
    config = {
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

      time.timeZone = "Europe/London";

      i18n = {
        defaultLocale = "en_GB.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_GB.UTF-8";
          LC_IDENTIFICATION = "en_GB.UTF-8";
          LC_MEASUREMENT = "en_GB.UTF-8";
          LC_MONETARY = "en_GB.UTF-8";
          LC_NAME = "en_GB.UTF-8";
          LC_NUMERIC = "en_GB.UTF-8";
          LC_PAPER = "en_GB.UTF-8";
          LC_TELEPHONE = "en_GB.UTF-8";
          LC_TIME = "en_GB.UTF-8";
        };
      };
    };
  };

  flake.modules.homeManager.baseleon = {};
}
