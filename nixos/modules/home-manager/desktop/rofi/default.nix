{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.desktop.rofi.enable = lib.mkEnableOption "Enable Rofi";
  config = lib.mkIf config.modules.desktop.rofi.enable {
    programs.rofi = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      enable = true;
      cycle = true;
      package = pkgs.rofi;
      terminal = "${pkgs.wezterm}/bin/wezterm";
      location = "center";
      modes = [
        "drun"
        "run"
        "window"
      ];
      extraConfig = {
        # Keybinds vim-like
        kb-mode-complete =  "";
        kb-row-up = "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
        kb-row-down = "Down,Control+j";
        kb-row-left = "Control+h";
        kb-row-right = "Control+l";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-remove-to-eol = "Control+Shift+e";
        kb-mode-next = "Shift+Right,Control+Tab";
        kb-mode-previous = "Shift+Left,Control+Shift+Tab";
        kb-remove-char-back = "BackSpace";

        drun-display-format = "{icon} {name}";
        disable-history = false;
        hide-scrollbar = false;

        show-icons = true;

        sidebar-mode = true;

        display-drun = " Apps";
        display-run = " Run";
        display-window = " Window";
        display-Network = " 󰤨 Network";
      };
      theme = {
        "*" = {
          # bg = mkLiteral "#1f1f23ee";
          # "bg-alt" = mkLiteral "#2a2a37";
          # "bg-selected" = mkLiteral "#7aa89f";
          # fg = mkLiteral "#dcd7ba";
          # "fg-alt" = mkLiteral "#727169";
          # "fg-selected" = mkLiteral "#1f1f23";
          border = 0;
          margin = 0;
          padding = 0;
          spacing = 0;
        };

        "window" = {
          fullscreen = false;
          transparency = "real";
          "background-color" = lib.mkForce (mkLiteral "transparent");
          padding = mkLiteral "10px 20px";
        };

        "mainbox" = {
          padding = mkLiteral "20px";
          "background-color" = lib.mkForce (mkLiteral "transparent");
        };

        "inputbar" = {
          # "background-color" = mkLiteral "@bg-alt";
          padding = mkLiteral "12px";
          margin = mkLiteral "0px 0px 20px 0px";
          "border-radius" = mkLiteral "8px";
          children = map mkLiteral ["prompt" "entry"];
        };

        "entry" = {
          "background-color" = lib.mkForce (mkLiteral "transparent");
          # "text-color" = mkLiteral "@fg";
          # "placeholder-color" = mkLiteral "@fg-alt";
          placeholder = "Type to search...";
          padding = mkLiteral "4px";
        };

        "prompt" = {
          "background-color" = lib.mkForce (mkLiteral "transparent");
          # "text-color" = mkLiteral "@fg";
          padding = mkLiteral "4px";
          margin = mkLiteral "0px 8px 0px 0px";
        };

        "listview" = {
          lines = 6;
          columns = 5;
          spacing = mkLiteral "20px";
          "fixed-columns" = true;
          "background-color" = lib.mkForce (mkLiteral "transparent");
        };

        "element" = {
          orientation = mkLiteral "vertical";
          padding = mkLiteral "20px 10px";
          children = [
            "element-icon"
            "element-text"
          ];
          "border-radius" = mkLiteral "8px";
          "background-color" = lib.mkForce (mkLiteral "transparent");
        };

        "element normal.normal" = {
          "background-color" = lib.mkForce (mkLiteral "transparent");
          # "text-color" = mkLiteral "@fg";
        };

        "element alternate.normal" = {
          "background-color" = lib.mkForce (mkLiteral "transparent");
          # "text-color" = mkLiteral "@fg";
        };

        "element selected.normal" = {
          # "background-color" = mkLiteral "@bg-selected";
          # "text-color" = mkLiteral "@fg-selected";
        };

        "element-icon" = {
          size = mkLiteral "64px";
          "horizontal-align" = mkLiteral "0.5";
          "background-color" = lib.mkForce (mkLiteral "transparent");
        };

        "element-text" = {
          "horizontal-align" = mkLiteral "0.5";
          "vertical-align" = mkLiteral "0.5";
          "background-color" = lib.mkForce (mkLiteral "transparent");
          # "text-color" = mkLiteral "inherit";
          margin = mkLiteral "8px 0px 0px 0px";
        };

        "mode-switcher" = {
          spacing = mkLiteral "20px";
          "background-color" = lib.mkForce (mkLiteral "transparent");
          margin = mkLiteral "20px 0px 0px 0px";
        };

        "button" = {
          padding = mkLiteral "8px 16px";
          "border-radius" = mkLiteral "8px";
          # "background-color" = mkLiteral "@bg-alt";
          # "text-color" = mkLiteral "@fg";
          "vertical-align" = mkLiteral "0.5";
          "horizontal-align" = mkLiteral "0.5";
        };

        "button selected" = {
          # "background-color" = mkLiteral "@bg-selected";
          # "text-color" = mkLiteral "@fg-selected";
        };

        "scrollbar" = {
          width = 4;
          border = 0;
          "handle-width" = 8;
          padding = 0;
          # "handle-color" = mkLiteral "@bg-selected";
          # "background-color" = mkLiteral "@bg-alt";
          margin = mkLiteral "0px 0px 0px 10px";
        };
      };
    };
  };
}
