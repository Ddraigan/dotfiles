{
  flake.modules.nixos.users-leon = {pkgs, ...}: {
    nix.settings = {
      trusted-users = ["tomvd"];
    };

    users = {
      leon = {
        shell = pkgs.zsh;
        isNormalUser = true;
        description = "Leon Jones";
        extraGroups = ["networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire" "docker" "gamemode"];
      };
    };
  };

  flake.modules.homeManager.users-leon = {};
}
