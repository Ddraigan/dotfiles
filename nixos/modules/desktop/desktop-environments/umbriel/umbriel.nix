{...}: {
  flake-file.inputs = {
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
  };

  nixos.umbriel = {
    lib,
    pkgs,
    config,
    inputs,
    ...
  }: {
    imports = [inputs.umbriel.nixosModules.default];
    nix.settings = {
      extra-substituters = ["https://umbriel.cachix.org"];
      extra-trusted-public-keys = [
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
      ];
    };
    programs = {
      umbriel.enable = true;
    };
  };

  homeManager.umbriel = {
    lib,
    pkgs,
    config,
    inputs,
    ...
  }: {
    imports = [inputs.umbriel.homeModules.default];
    programs = {
      umbriel = {
        enable = true;
        settings = {
          general.autostart = ["noctalia" "wezterm"];
          output."DP-1" = {
            hdr = "on";
            sdr_white = 203;
          };
        };
      };
    };
  };
}
