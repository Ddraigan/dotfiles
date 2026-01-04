# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules.nix = {
    greetd.enable = true;
    desktop = {
      hyprland.enable = true;
    };
  };

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config.allowUnfree = true;
  };

  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "dvorak";
      };
    };
  };

  programs = {
    dconf.enable = true;
    zsh.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  environment = {
    systemPackages = [
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

  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {}; # Can't unlock without this}
    polkit.enable = true;
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Something here fixes screen flicker - max_cstate=3 i think
    kernelModules = ["kvm-intel"];
    initrd.kernelModules = ["i915"];
    kernelParams = ["i915.enable_psr=0" "intel_idle.max_cstate=3"];
  };

  networking = {
    hostName = "leon-dell";
    # wireless.enable = true;
    networkmanager.enable = true;
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

  fonts = {
    fontDir.enable = true;
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

  # Configure console keymap
  console.keyMap = "dvorak";

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
  system.stateVersion = "25.11"; # Did you read the comment?
}
