{...}: {
  nixos.leon = {
    pkgs,
    lib,
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
  };
}
