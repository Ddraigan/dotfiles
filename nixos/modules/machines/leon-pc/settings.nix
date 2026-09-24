{...}: {
  nixos.leon-pc = {pkgs, ...}: {
    imports = [
      ./_host/hardware-configuration.nix
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
  homeManager.leon-pc-leon = {
    inputs,
    config,
    pkgs,
    ...
  }: {
    modules = {
      desktop = {
        hypr = {
          hyprland.mod = "SUPER";
          hyprlock.mainMonitor = "DP-1";
        };
        nemo.extensions = [
          pkgs.nemo-preview
        ];
      };
    };

    programs = {
      mpv = {
        enable = true;
      };
      element-desktop.enable = true;
      firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };
    };

    wayland.windowManager.hyprland.settings = {
      config = {
        input = {
          kb_variant = "";
        };
      };
      monitor = [
        {
          _args = [
            {
              output = "DP-1";
              mode = "preferred";
              position = "0x0";
              scale = 1;
              bitdepth = 10;
              cm = "hdr";
              sdr_max_luminance = 250;
              sdr_min_luminance = 0.005;
              sdrbrightness = 1.0;
              sdrsaturation = 1.0;
            }
          ];
        }
        {
          _args = [
            {
              output = "DP-2";
              mode = "preferred";
              position = "auto-left";
              scale = "auto";
              bitdepth = 8;
            }
          ];
        }
      ];
    };

    home = {
      stateVersion = "24.05";
      packages = [
        pkgs.just
        inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.dgop

        # Image Stuff
        pkgs.gimp
        pkgs.loupe

        pkgs.unzip
        pkgs.zip
        pkgs.ripgrep
        pkgs.fzf
      ];
    };

    xdg.mimeApps.enable = true;
  };
}
