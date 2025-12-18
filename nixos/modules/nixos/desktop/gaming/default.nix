{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  options.modules.nix.desktop.gaming.enable = lib.mkEnableOption "Enable Gaming Config";
  config = lib.mkIf config.modules.nix.desktop.gaming.enable {
    environment.systemPackages = with pkgs; [
      mangohud
      # NOTE: Changed 25.11
      protonup-ng
      protonup-qt
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        extraCompatPackages = [
          pkgs.proton-ge-bin
          # inputs.nix-proton-cachyos.packages.${pkgs.stdenv.hostPlatform.system}.proton-cachyos
        ];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode.enable = true;
    };
  };
}
