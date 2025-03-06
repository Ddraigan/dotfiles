{ inputs, lib, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  # stylix.opacity = {
  #   applications = 0.4;
  #   terminal = 1.0;
  #   desktop = 0.4;
  #   popups = 0.8;
  # };

  modules = {
    desktop = {
      thunar = false;
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      leon = {
        isNormalUser = true;
        description = "Leon Jones";
        extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire" ];
        openssh.authorizedKeys.keys =
          let
            authorizedKeys = pkgs.fetchurl {
              url = "https://github.com/Ddraigan.keys";
              hash = "SHA256:rhL8wfj3Cr48CbD+J+pgLcYqIegVdZPx9F+U/VnuG6M";
            };
          in
          pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
        #packages = with pkgs; [ ];
      };
    };
  };

  nixpkgs = {
    overlays = [ inputs.self.overlays.unstable-packages ];
    config = {
      allowUnfree = true;
    };
  };

  hardware = {
    pulseaudio = {
      enable = false;
      # package = pkgs.pulseaudioFull;
    };
    bluetooth = {
      enable = false;
      powerOnBoot = false;
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
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
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
      pkgs.hyprpolkitagent
      pkgs.pulseaudio
      pkgs.xwaylandvideobridge
      pkgs.helvum
      pkgs.spotify
      pkgs.nemo-with-extensions
      # pkgs.bitwarden
      pkgs.discord-canary
      # pkgs.vesktop
      # pkgs.webcord
      # (pkgs.discord.override {
      #  withVencord = true;
      #  })
      # pkgs.unstable.hyprnotify
      # (pkgs.heroic.override {
      #   extraPkgs = pkgs: [
      #     pkgs.gamescope
      #   ];
      # })
    ];
    variables = {
      # UWSM manages these
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/leon/.steam/root/compatibilitytools.d";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
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
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
    };

  programs = {
    dconf.enable = true;
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
      # withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
    extraPortals = [
      # pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
    ];
  };

  security = {
    rtkit.enable = true;
    pam.services.hyprlock = { }; # Can't unlock without this}
    polkit.enable = true;
  };

  fonts.fontDir.enable = true;

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
  networking.firewall.allowedTCPPorts = [ 57621 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
