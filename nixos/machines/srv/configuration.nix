{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules.nix.containers = {
    traefik.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    cowsay
    lolcat
    hello
  ];

  programs.zsh.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };
    displayManager.gdm.enable = false;
    desktopManager.gnome.enable = false;
  };

  virtualisation = {
    vmVariant = {
      # following configuration is added only when building VM with build-vm
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
      };
    };
    oci-containers = {
      backend = "docker";
    };
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [22];
  };

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.leon = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK211oX+SFHFii/sP3VpPK46PwiZ+wMbSYc+qzm1RKHF leon@leon-pc"
      ];
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

  system.stateVersion = "25.11";
}
