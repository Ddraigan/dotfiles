{...}: {
  nixos.nixpkgs = {inputs, ...}: {
    nixpkgs = {
      overlays = [inputs.self.overlays.unstable-packages];
      config.allowUnfree = true;
    };
  };
}
