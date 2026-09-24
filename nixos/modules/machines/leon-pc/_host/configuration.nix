{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  fileSystems = {
    "/mnt/isa/media" = {
      device = "10.69.1.21:/mnt/isa/media";
      fsType = "nfs";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = false;
      powerOnBoot = false;
    };
    keyboard.qmk.enable = true;
    # graphics = {
    # May fix lag if i experiance it - Hyprland version of mesa drivers
    # package = pkgs.unstable.mesa.drivers;
    #
    # # if you also want 32-bit support (e.g for Steam)
    # enable32Bit = true;
    # package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;
    # };
  };

  services = {
    upower.enable = true;
    udev.packages = with pkgs; [via android-tools];
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."10-stable-usb.conf" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 512;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 1024;
        };
      };
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  environment = {
    systemPackages = [
      pkgs.crosspipe
      pkgs.qmk
      pkgs.via
      pkgs.libnotify
      pkgs.rustup
      pkgs.nixd
      (pkgs.discord-canary.override
        {
          withVencord = true;
        })
    ];
  };

  programs = {
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
    dconf.enable = true;
    solaar.enable = true;
    nix-ld.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  networking = {
    hostName = "leon-pc";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall = {
      allowedTCPPorts = [57621 4321 5201];
      allowedUDPPorts = [5353];
    };
  };

  virtualisation = {
    docker.enable = true;
    vmVariant = {
      virtualisation = {
        memorySize = 4096;
        cores = 4;
        graphics = true;
        forwardPorts = [
          {
            from = "host";
            host.port = 2222;
            guest.port = 22;
          }
        ];
      };
      users.users.leon = {
        initialPassword = "changeme";
      };
    };
    # qemu.options = [
    #   "-device virtio-vga-gl"
    #   "-display sdl,gl=on,show-cursor=off"
    #   "-audio pa,model=hda"
    #   # "-vga virtio"
    #   # "-device virtio-gpu-gl"
    #   # "-display gtk,gl=on"
    # ];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
