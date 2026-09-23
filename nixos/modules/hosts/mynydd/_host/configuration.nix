{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules.nix = {
    containers = {
      domain = "ddraigan.com";
      mainUser = "leon";
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    just
  ];

  programs.zsh.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = false;
  };

  fileSystems = {
    "/mnt/isa/media" = {
      device = "10.69.1.21:/mnt/isa/media";
      fsType = "nfs";
    };
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 2048; # Use 2048MiB memory.
        cores = 3;
        graphics = false;
        forwardPorts = [
          {
            from = "host";
            host.port = 2222;
            guest.port = 22;
          }
        ];
      };
    };
    docker = {
      enable = true;
      rootless = {
        enable = false;
        # setSocketVariable = true;
      };
      daemon.settings = {
        data-root = "/docker-data";
        userland-proxy = false;
        dns = ["10.69.1.11"];
      };
    };
    oci-containers = {
      backend = "docker";
    };
  };

  networking = {
    hostName = "mynydd";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [22];
  };

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = ["root" "leon"];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.leon = {
      isNormalUser = true;
      initialPassword = "";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK211oX+SFHFii/sP3VpPK46PwiZ+wMbSYc+qzm1RKHF leon@leon-pc"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKQI0ISRODZQeEdApapX+91z0nH6GqM7hRJxIit4Hic lkjjones1999@gmail.com"
      ];
    };
  };

  system.stateVersion = "25.11";
}
