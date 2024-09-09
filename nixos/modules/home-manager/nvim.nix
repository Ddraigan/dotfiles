{ pkgs, outputs, lib, config, ... }: {
  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];

    # Config for nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  config = {
    home.packages = [
      pkgs.unstable.neovim
    ];

    home.file = {
      ".config/nvim" = {
        source = ../../../nvim;
      };
    };
  };
}
