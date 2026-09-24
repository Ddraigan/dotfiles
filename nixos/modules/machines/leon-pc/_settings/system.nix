{...}: {
  nixos.leon-pc = {pkgs, ...}: {
    imports = [
      ./_hardware/hardware-configuration.nix
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
    };

    system.stateVersion = "24.05";
  };
}
