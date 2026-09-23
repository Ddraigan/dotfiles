{...}: {
  nixos.thunar =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      config = {
    environment.systemPackages = with pkgs; [
      # ffmpegthumbnailer
    ];
    programs = {
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
      xfconf.enable = true;
    };
    services = {
      gvfs.enable = true; # Mount, trash, and other functionalities
      tumbler.enable = true; # Thumbnail support for images
    };
  };
};
}
