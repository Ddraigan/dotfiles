{
  config,
  lib,
  ...
}: let
  terminals = config.modules.terminal;

  enabledTerminals =
    lib.filterAttrs (_: term: term.enable or false) terminals;

  primaryCandidates =
    lib.filterAttrs (_: term: term.primary_terminal or false) enabledTerminals;

  numPrimaryCandidates = builtins.length (builtins.attrNames primaryCandidates);
in {
  options = {
    global.primaryTerminalCommand = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = "Launch command of the chosen default terminal.";

      default =
        if numPrimaryCandidates == 1
        then builtins.head (builtins.attrNames primaryCandidates)
        else if enabledTerminals != {}
        then builtins.head (builtins.attrNames enabledTerminals)
        else null;
    };
  };

  config = {
    assertions = [
      {
        assertion = numPrimaryCandidates <= 1;
        message = ''
          More than one terminal is marked as `primary-terminal = true` (modules.terminal):

          ${builtins.toString (builtins.attrNames primaryCandidates)}

          Only one terminal may be primary.
        '';
      }
    ];

    warnings =
      lib.optional
      (numPrimaryCandidates == 0 && enabledTerminals != {})
      ''
        No terminal is marked as primary (primary-terminal = true) in modules.terminal.
        The first enabled terminal will be chosen automatically: ${
          builtins.head (builtins.attrNames enabledTerminals)
        }
      '';
  };
}
