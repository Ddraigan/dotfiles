{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  wezterm-cwd = import ./scripts/wezterm-cwd.nix {inherit pkgs;};
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/secureboot.nix
  ];

  modules.nix = {
    nvidia.enable = true;
    greetd.enable = true;
    desktop = {
      hyprland.enable = true;
      gaming.enable = true;
    };
    sunshine.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      leon = {
        isNormalUser = true;
        description = "Leon Jones";
        extraGroups = ["networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire" "docker"];
        openssh.authorizedKeys.keys = let
          authorizedKeys = pkgs.fetchurl {
            url = "https://github.com/Ddraigan.keys";
            hash = "SHA256:rhL8wfj3Cr48CbD+J+pgLcYqIegVdZPx9F+U/VnuG6M";
          };
        in
          pkgs.lib.splitString "\n" (builtins.readFile authorizedKeys);
      };
      keane = {
        isNormalUser = true;
        description = "Keane";
        extraGroups = ["audio" "sound" "video" "input" "pipewire"];
      };
    };
  };

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config.allowUnfree = true;
  };

  hardware = {
    bluetooth = {
      enable = false;
      powerOnBoot = false;
    };
    # graphics = {
    # May fix lag if i experiance it - Hyprland version of mesa drivers
    # package = pkgs.unstable.mesa.drivers;
    #
    # # if you also want 32-bit support (e.g for Steam)
    # enable32Bit = true;
    # package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;
    # };
  };

  # Configure keymap in X11
  services = {
    ollama = {
      enable = false;
      # Optional: preload models, see https://ollama.com/library
      loadModels = ["llama3"];
      acceleration = "cuda";
    };
    upower.enable = true;
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
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
      wezterm-cwd
      pkgs.upower
      pkgs.helvum
      # NOTE: Changed 25.11
      pkgs.bitwarden-desktop
      pkgs.rustup
      pkgs.nixd
      (pkgs.discord-canary.override
        {
          withVencord = true;
        })
    ];
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      nix-path = config.nix.nixPath;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  programs = {
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
    dconf.enable = true;
    zsh.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {}; # Can't unlock without this
    polkit.enable = true;
  };

  fonts = {
    fontDir.enable = true;
  };

  networking = {
    hostName = "leon-pc";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  virtualisation.docker.enable = true;

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
  networking.firewall = {
    allowedTCPPorts = [57621 4321];
    allowedUDPPorts = [5353];
  };
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
