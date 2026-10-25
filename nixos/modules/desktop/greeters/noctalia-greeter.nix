{...}: {
  nixos.noctalia-greeter = {
    lib,
    pkgs,
    config,
    fonts,
    ...
  }: {
    services.displayManager.noctalia-greeter = {
      enable = true;
      passwordlessSyncUsers = ["leon"];
      settings = {
        scheme = "Synced";
        cursor.size = 24;
        keyboard.layout = "us";
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };
  };
}
