{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  nix.settings.experimental-features = "nix-command flakes";

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
  users.users = {
    root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK211oX+SFHFii/sP3VpPK46PwiZ+wMbSYc+qzm1RKHF leon@leon-pc"
      ];
    };
  };

  networking = {
    hostName = "installer";
    networkmanager.enable = true;
  };

  system.stateVersion = "25.11";
}
