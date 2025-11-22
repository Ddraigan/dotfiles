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
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  modules.nix.nvidia.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      leon = {
        isNormalUser = true;
        description = "Leon Jones";
        extraGroups = ["networkmanager" "wheel" "audio" "sound" "video" "input" "pipewire"];
        openssh.authorizedKeys.keys = let
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
    overlays = [inputs.self.overlays.unstable-packages];
    config.allowUnfree = true;
  };

  hardware = {
    bluetooth = {
      enable = false;
      powerOnBoot = false;
    };
    graphics = {
      enable = true;
      # May fix lag if i experiance it - Hyprland version of mesa drivers
      # package = pkgs.unstable.mesa.drivers;
      #
      # # if you also want 32-bit support (e.g for Steam)
      # enable32Bit = true;
      # package32 = pkgs.unstable.pkgsi686Linux.mesa.drivers;
    };
  };

  # Configure keymap in X11
  services = {
    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "uwsm start -- hyprland.desktop";
    #       user = "leon";
    #     };
    #     default_session = initial_session;
    #   };
    # };
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
    displayManager = {
      sddm = {
        wayland.enable = true;
      };
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  environment = {
    systemPackages = [
      # inputs.nixai.packages.${pkgs.system}.default
      pkgs.sbctl
      wezterm-cwd
      pkgs.upower
      pkgs.mangohud
      pkgs.protonup
      pkgs.hyprpolkitagent
      # pkgs.pulseaudio
      pkgs.kdePackages.xwaylandvideobridge
      pkgs.helvum
      # pkgs.spotify
      pkgs.bitwarden
      pkgs.rustup
      pkgs.nixd
      (pkgs.discord-canary.override
        {
          withVencord = true;
        })
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
      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_TYPE = "wayland";
      # XDG_SESSION_DESKTOP = "Hyprland";
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
    # regreet.enable = true;
    gdk-pixbuf.modulePackages = [pkgs.librsvg];
    dconf.enable = true;
    zsh.enable = true;
    uwsm = {
      enable = true;
      # waylandCompositors = {
      #   hyprland = {
      #     prettyName = "Hyprland";
      #     comment = "Hyprland compositor managed by UWSM";
      #     binPath = "/home/leon/.nix-profile/bin/Hyprland";
      #   };
      # };
    };
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
    };
    extraPortals = [
      # pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      # pkgs.xdg-desktop-portal-wlr
    ];
  };

  security = {
    rtkit.enable = true;
    pam.services.hyprlock = {}; # Can't unlock without this}
    polkit.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    # packages = with pkgs; [
    #   candy-icons
    # ];
  };

  # Bootloader.

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

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
  networking.firewall.allowedTCPPorts = [57621 4321];
  networking.firewall.allowedUDPPorts = [5353];
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
# modules = {
#   desktop = {
#     thunar = false;
#   };
# };
# stylix = {
#   enable = true;
#   autoEnable = true;
#   homeManagerIntegration.autoImport = false;
#   cursor = {
#     package = pkgs.bibata-cursors;
#     name = "Bibata-Modern-Ice";
#     size = 16;
#   };
#   fonts = {
#     monospace = {
#       package = pkgs.nerd-fonts.hack;
#       name = "Hack Nerd Font";
#     };
#     sansSerif = {
#       package = pkgs.dejavu_fonts;
#       name = "DejaVu Sans";
#     };
#     serif = {
#       package = pkgs.dejavu_fonts;
#       name = "DejaVu Serif";
#     };
#   };
#   opacity = {
#     applications = 0.5;
#   };
#   base16Scheme = {
#     base00 = "1e1e2e"; # base
#     base01 = "181825"; # mantle
#     base02 = "313244"; # surface0
#     base03 = "45475a"; # surface1
#     base04 = "585b70"; # surface2
#     base05 = "cdd6f4"; # text
#     base06 = "f5e0dc"; # rosewater
#     base07 = "b4befe"; # lavender
#     base08 = "f38ba8"; # red
#     base09 = "fab387"; # peach
#     base0A = "f9e2af"; # yellow
#     base0B = "a6e3a1"; # green
#     base0C = "94e2d5"; # teal
#     base0D = "89b4fa"; # blue
#     base0E = "cba6f7"; # mauve
#     base0F = "f2cdcd"; # flamingo
#   };
# };

