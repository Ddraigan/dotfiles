{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.nemo = {
    enable = lib.mkEnableOption "Install configure and enable Nemo file manager";
    openInTerminal = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        exec = config.global.terminalCommand;
        execArg = "";
      };
      description = "Command and argument to open terminal from Nemo";
    };
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra Nemo extensions to install.";
    };
  };

  config = lib.mkIf config.modules.desktop.nemo.enable (
    let
      cfg = config.modules.desktop.nemo;
    in {
      home = {
        packages =
          [
            pkgs.nemo-with-extensions
          ]
          ++ cfg.extensions;
        file = {
          ".gnome2/accels/nemo".text = ''
            (gtk_accel_path "<Actions>/DirViewActions/OpenInTerminal" "F4")
          '';
        };
      };
      xdg = {
        desktopEntries.nemo = {
          name = "Nemo";
          exec = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
        mimeApps = {
          enable = true;
          defaultApplications = {
            "inode/directory" = ["nemo.desktop"];
            "application/x-gnome-saved-search" = ["nemo.desktop"];
          };
        };
      };
      dconf.settings."org/cinnamon/desktop/applications/terminal" = {
        exec = cfg.openInTerminal.exec;
        exec-arg = cfg.openInTerminal.execArg;
      };
    }
  );
}
