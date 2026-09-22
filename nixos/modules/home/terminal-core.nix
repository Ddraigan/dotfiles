{...}: {
  flake.modules.homeManager.terminal-core =
    {
      config,
      lib,
      ...
    }:
    let
      terminals = config.modules.terminal;

      primaryCandidates =
        lib.filterAttrs (_: term: term.primaryTerminal or false) terminals;

      numPrimaryCandidates = builtins.length (builtins.attrNames primaryCandidates);
    in
    {
      options = {
        global.primaryTerminal = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          description = "Launch command of the chosen default terminal.";

          default =
            if numPrimaryCandidates == 1
            then builtins.head (builtins.attrNames primaryCandidates)
            else if terminals != {}
            then builtins.head (builtins.attrNames terminals)
            else null;
        };
      };

      config = {
        assertions = [
          {
            assertion = numPrimaryCandidates <= 1;
            message = ''
              More than one terminal is marked as `primaryTerminal = true` (modules.terminal):

              ${builtins.toString (builtins.attrNames primaryCandidates)}

              Only one terminal may be primary.
            '';
          }
        ];

        warnings =
          lib.optional
          (numPrimaryCandidates == 0 && terminals != {})
          ''
            No terminal is marked as primary (primaryTerminal = true) in modules.terminal.
            The first imported terminal will be chosen automatically: ${
              builtins.head (builtins.attrNames terminals)
            }
          '';
      };
    };
}