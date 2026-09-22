{...}: {
  flake.modules.nixos.baseleon = {
    pkgs,
    config,
    lib,
    ...
  }: {
    config = {
      users = {
        defaultUserShell = pkgs.zsh;
        users = {
          leon = {
            isNormalUser = true;
            description = "Leon Jones";
            extraGroups = ["networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire" "docker" "gamemode" "kvm" "adbusers"];
            openssh.authorizedKeys.keys = let
              authorizedKeys = pkgs.fetchurl {
                url = "https://github.com/Ddraigan.keys";
                hash = "SHA256:rhL8wfj3Cr48CbD+J+pgLcYqIegVdZPx9F+U/VnuG6M";
              };
            in
              pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
          };
        };
      };
    };
  };
  flake.modules.homeManager.baseleon = {};
}
