{inputs, ...}: {
  unstable-packages = final: _prev: {
    unstable =
      import inputs.nixpkgs-unstable
      {
        system = final.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
  };
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs {
      system = prev.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
