{
  inputs,
  config,
  pkgs,
  ...
}: {
  global.home.fonts = {
    enable = true;
    mono = {
      name = "Hack Nerd Font, Hack NF";
      package = pkgs.nerd-fonts.hack;
    };
    sans = {
      name = "DejaVu Sans";
      package = pkgs.dejavu_fonts;
    };
    serif = {
      name = "DejaVu Serif";
      package = pkgs.dejavu_fonts;
    };
    icons = {
      enable = true;
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
      size = "32x32";
    };
  };
  modules = {
    theme.stylix.enable = true;
    desktop = {
	zen.enable = false;
    };
    terminal = {
      nvim.enable = true;
      fastfetch.enable = true;
      starship.enable = true;
      tmux.enable = true;
      zoxide.enable = true;
      eza.enable = true;
      zsh.enable = true;
    };
  };

  nixpkgs = {
    overlays = [inputs.self.overlays.unstable-packages];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      settings = {
        user = {
          email = "lkjjones1999@gmail.com";
          name = "Ddraigan";
        };
        init.defaultBranch = "main";
      };
    };
  };

  dconf.enable = false;

  home = {
    username = "leon";
    homeDirectory = "/home/leon";
    stateVersion = "24.05"; # Don't change this I'm pretty sure
    packages = [
      pkgs.just
      inputs.diff-tool.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.dgop

      pkgs.opencode

      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.fzf
    ];
    shellAliases = {
      byebyewindows = "export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/mnt/c/' | tr '\n' ':')";
    };
  };
}
