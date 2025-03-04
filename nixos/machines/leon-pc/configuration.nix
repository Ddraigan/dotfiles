{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      leon = {
        isNormalUser = true;
        description = "Leon Jones";
        extraGroups = [ "networkmanager" "wheel" "sound" "video" "input" ];
        #openssh.authorizedKeys.keys = [ ];
        #packages = with pkgs; [ ];
      };
    };
  };

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable-packages ];
    config = {
      allowUnfree = true;
      pulseaudio = false;
    };
  };

  hardware = {
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };
    graphics = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false; #Unlikely to need this one (Experimental)
        finegrained = false; #Puts the GPU to sleep, don't want this
      };
      open = true;
      nvidiaSettings = true;
    };
  };

  # Configure keymap in X11
  services = {
    upower.enable = true;
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  environment = {
    systemPackages = [
      pkgs.upower
      pkgs.home-manager
      pkgs.mangohud
      pkgs.protonup
      # pkgs.unstable.hyprnotify
      # (pkgs.heroic.override {
      #   extraPkgs = pkgs: [
      #     pkgs.gamescope
      #   ];
      # })
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/leon/.steam/root/compatibilitytools.d";
    };
  };

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        nix-path = config.nix.nixPath;
      };
    };

  # programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  programs = {
    dconf.enable = true;
    zsh.enable = true;
    hyprland.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  fonts.fontDir.enable = true;

  # Bootloader.
  # boot.loader.grub = {
  #   enable = true;
  #   device = "/dev/sda";
  #   useOSProber = true;
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
    hostName = "leon-pc";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  #sound.enable = true;
  #hardware.pulseaudio = {
  #  enable = true;
  #};
  #security.rtkit.enable = true;
}
