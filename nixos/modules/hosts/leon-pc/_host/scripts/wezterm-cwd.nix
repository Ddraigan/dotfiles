{pkgs}:
pkgs.writeShellScriptBin "wezterm-cwd" ''
  ${pkgs.wezterm}/bin/wezterm start --cwd "$PWD"
''
