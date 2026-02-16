{
  config,
  inputs,
  pkgs,
  ...
}: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    git
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
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings = {
        data-root = "/docker-data";
        userland-proxy = false;
      };
    };
    oci-containers = let
      system = pkgs.system;
      nixTestImage = inputs.nix-test.packages.${system}.docker;
    in {
      backend = "docker";
      containers = {
        some-container = {
          image = "nix-test:latest";
          imageFile = nixTestImage;
          autoStart = true;
        };
      };
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

  users = {
    defaultUserShell = pkgs.zsh;
    users.leon = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        # "docker"
      ];
      initialPassword = "test";
    };
  };

  system.stateVersion = "25.11";
}
