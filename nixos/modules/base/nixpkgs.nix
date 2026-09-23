{...}: {
  nixos.nixpkgs = {inputs, ...}: {
    nixpkgs = {
      overlays = [inputs.self.overlays.unstable-packages];
      config.allowUnfree = true;
    };
  };
  homeManager.nixpkgs = {inputs, ...}: {
    nixpkgs = {
      overlays = [inputs.self.overlays.unstable-packages];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  };
}
