{...}: {
  nixos.nixpkgs = {inputs, ...}: {
    nixpkgs = {
      overlays = with inputs.self.overlays; [unstable-packages stable-packages];
      config.allowUnfree = true;
    };
  };
  homeManager.nixpkgs = {inputs, ...}: {
    nixpkgs = {
      overlays = with inputs.self.overlays; [unstable-packages stable-packages];
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  };
}
