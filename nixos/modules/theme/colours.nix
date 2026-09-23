{...}: {
  homeManager.colours =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        ./_colours
      ];
    };
}