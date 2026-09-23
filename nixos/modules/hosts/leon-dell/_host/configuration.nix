{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules.nix = {
    greetd.keyboardVariant = "dvorak";
  };

  services = {
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    upower.enable = true;
    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd;
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

  virtualisation.docker.enable = true;

  programs = {
    dconf.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.libimobiledevice
      pkgs.idevicerestore
      pkgs.usbutils
      pkgs.ifuse
      pkgs.crosspipe
      pkgs.rustup
      pkgs.nixd
      (pkgs.discord-canary.override
        {
          withVencord = true;
        })
    ];
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = ["aarch64-linux"];
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

  fonts = {
    fontDir.enable = true;
  };

  console.keyMap = "dvorak";

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
